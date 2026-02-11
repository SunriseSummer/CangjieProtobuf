#include <node_api.h>
#include <node.h>
#include <uv.h>

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <memory>
#include <mutex>
#include <new>
#include <string>
#include <vector>

extern "C" {
struct JsBuffer {
    uint8_t* data;
    size_t size;
};
}

namespace {
std::mutex g_lock;
std::shared_ptr<node::MultiIsolatePlatform> g_platform;
node::Environment* g_node_env = nullptr;
v8::Isolate* g_isolate = nullptr;
v8::ArrayBuffer::Allocator* g_allocator = nullptr;
napi_env g_env = nullptr;
napi_ref g_handler_ref = nullptr;
uv_loop_t g_loop;
bool g_initialized = false;
constexpr const char* kDefaultScriptPath = "./js/interop.js";

bool IsValidScriptPath(const std::string& path) {
    if (path.empty()) {
        return false;
    }
    if (path.find("..") != std::string::npos) {
        return false;
    }
    if (path.find('\n') != std::string::npos || path.find('\r') != std::string::npos ||
        path.find('\0') != std::string::npos) {
        return false;
    }
    if (path.size() < 3 || path.substr(path.size() - 3) != ".js") {
        return false;
    }
    std::error_code error;
    return std::filesystem::is_regular_file(path, error);
}

bool LoadHandler() {
    napi_value global;
    if (napi_get_global(g_env, &global) != napi_ok) {
        return false;
    }

    napi_value handler;
    if (napi_get_named_property(g_env, global, "__cj_handle", &handler) != napi_ok) {
        return false;
    }

    if (napi_create_reference(g_env, handler, 1, &g_handler_ref) != napi_ok) {
        return false;
    }

    return true;
}
}

extern "C" bool cj_js_init() {
    std::lock_guard<std::mutex> guard(g_lock);
    if (g_initialized) {
        return true;
    }

    const char* script_env = std::getenv("CJ_JS_ENTRY");
    std::string script_path = kDefaultScriptPath;
    if (script_env && IsValidScriptPath(script_env)) {
        script_path = script_env;
    } else if (script_env) {
        std::fprintf(stderr, "CJ_JS_ENTRY is invalid; falling back to %s\n", kDefaultScriptPath);
        uv_os_unsetenv("CJ_JS_ENTRY");
    }
    std::vector<std::string> args = {"node", script_path};
    std::vector<std::string> exec_args;
    std::vector<std::string> errors;

    g_platform = node::MultiIsolatePlatform::Create(4);
    v8::V8::InitializePlatform(g_platform.get());
    v8::V8::Initialize();
    node::InitializeOncePerProcess(args, exec_args);

    uv_loop_init(&g_loop);

    v8::Isolate::CreateParams create_params;
    g_allocator = v8::ArrayBuffer::Allocator::NewDefaultAllocator();
    create_params.array_buffer_allocator = g_allocator;
    g_isolate = v8::Isolate::New(create_params);

    {
        v8::Isolate::Scope isolate_scope(g_isolate);
        v8::HandleScope handle_scope(g_isolate);
        v8::Local<v8::Context> context = node::NewContext(g_isolate);
        v8::Context::Scope context_scope(context);

        g_node_env = node::CreateEnvironment(g_isolate, context, args, exec_args, false);
        g_env = node::GetCurrentEnvironment(context)->GetNapiEnv();

        const std::string bootstrap =
            "globalThis.__cj_handle = require(process.env.CJ_JS_ENTRY || '" +
            std::string(kDefaultScriptPath) + "').handleMessage;";
        node::LoadEnvironment(g_node_env, bootstrap.c_str());

        if (!LoadHandler()) {
            return false;
        }
    }

    g_initialized = true;
    return true;
}

extern "C" JsBuffer cj_js_call(const uint8_t* data, size_t size) {
    std::lock_guard<std::mutex> guard(g_lock);
    JsBuffer output{nullptr, 0};

    if (!g_initialized || g_env == nullptr || g_handler_ref == nullptr) {
        return output;
    }

    napi_handle_scope scope;
    if (napi_open_handle_scope(g_env, &scope) != napi_ok) {
        return output;
    }

    napi_value handler;
    if (napi_get_reference_value(g_env, g_handler_ref, &handler) != napi_ok) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    napi_value global;
    if (napi_get_global(g_env, &global) != napi_ok) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    void* buffer_data = nullptr;
    napi_value buffer;
    if (napi_create_buffer_copy(g_env, size, data, &buffer_data, &buffer) != napi_ok) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    napi_value argv[1] = {buffer};
    napi_value result;
    if (napi_call_function(g_env, global, handler, 1, argv, &result) != napi_ok) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    bool is_buffer = false;
    if (napi_is_buffer(g_env, result, &is_buffer) != napi_ok || !is_buffer) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    void* result_data = nullptr;
    size_t result_size = 0;
    if (napi_get_buffer_info(g_env, result, &result_data, &result_size) != napi_ok) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    output.data = new (std::nothrow) uint8_t[result_size];
    if (output.data == nullptr) {
        napi_close_handle_scope(g_env, scope);
        return output;
    }

    std::memcpy(output.data, result_data, result_size);
    output.size = result_size;

    napi_close_handle_scope(g_env, scope);
    return output;
}

extern "C" void cj_js_free(JsBuffer buffer) {
    delete[] buffer.data;
}

extern "C" void cj_js_shutdown() {
    std::lock_guard<std::mutex> guard(g_lock);
    if (!g_initialized) {
        return;
    }

    if (g_handler_ref != nullptr) {
        napi_delete_reference(g_env, g_handler_ref);
        g_handler_ref = nullptr;
    }

    if (g_node_env != nullptr) {
        node::EmitExit(g_node_env);
        node::CleanupEnvironment(g_node_env);
        g_node_env = nullptr;
    }

    if (g_isolate != nullptr) {
        g_isolate->Dispose();
        g_isolate = nullptr;
    }

    if (g_allocator != nullptr) {
        delete g_allocator;
        g_allocator = nullptr;
    }

    if (uv_loop_close(&g_loop) != 0) {
        uv_run(&g_loop, UV_RUN_NOWAIT);
        uv_loop_close(&g_loop);
    }
    v8::V8::Dispose();
    v8::V8::ShutdownPlatform();
    g_platform.reset();
    g_initialized = false;
}

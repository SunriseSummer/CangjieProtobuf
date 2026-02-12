cmake_minimum_required(VERSION 3.16)
project(cj_node_bridge LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(NODE_DIR "" CACHE PATH "Path to Node.js headers (contains include/node)")
set(NODE_LIBRARY "" CACHE FILEPATH "Path to libnode shared library")

if (NOT NODE_DIR)
    message(FATAL_ERROR "Set NODE_DIR to your Node.js install (contains include/node)")
endif()

if (NOT NODE_LIBRARY)
    message(FATAL_ERROR "Set NODE_LIBRARY to the libnode shared library")
endif()

add_library(cj_node_bridge SHARED node_bridge.cc)

target_include_directories(cj_node_bridge PRIVATE ${NODE_DIR}/include/node)

target_link_libraries(cj_node_bridge PRIVATE ${NODE_LIBRARY} uv pthread dl)

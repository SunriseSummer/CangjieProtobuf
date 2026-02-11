const path = require('path');
const protobuf = require('protobufjs');

const protoPath = path.join(__dirname, '..', 'proto', 'interop.proto');
const root = protobuf.loadSync(protoPath);

const CjRequest = root.lookupType('interop.CjRequest');
const JsReply = root.lookupType('interop.JsReply');

function handleMessage(buffer) {
  const request = CjRequest.decode(buffer);
  const obj = CjRequest.toObject(request, {
    longs: Number,
    bytes: Buffer,
    defaults: true,
  });

  const replyItems =
    obj.items && obj.items.length > 0 ? obj.items : obj.primaryItem ? [obj.primaryItem] : [];
  const average = replyItems.length
    ? replyItems.reduce((sum, item) => sum + item.price, 0) / replyItems.length
    : 0;

  const reply = JsReply.create({
    status: `ok:${obj.title}`,
    items: replyItems,
    defaultAddress: obj.addresses && obj.addresses.length > 0 ? obj.addresses[0] : undefined,
    payloads: [obj.raw],
    average,
  });

  return JsReply.encode(reply).finish();
}

globalThis.__cj_handle = handleMessage;
module.exports = { handleMessage };

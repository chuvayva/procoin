import { Buffer } from "buffer";
import ethUtil from "ethereumjs-util";

const formattedAddress = address =>
  Buffer.from(ethUtil.stripHexPrefix(address), "hex");
const formattedInt = int => ethUtil.setLengthLeft(+int, 32);
const hashedTightPacked = args => ethUtil.sha3(Buffer.concat(args));

const signTransfer = (tokenAddress, to, amount, fee, nonce, privateKey) => {
  const components = [
    formattedAddress(tokenAddress),
    formattedAddress(to),
    formattedInt(amount),
    formattedInt(fee),
    formattedInt(nonce)
  ];

  const privateKeyBuffer = Buffer.from(privateKey, "hex");
  const vrs = ethUtil.ecsign(hashedTightPacked(components), privateKeyBuffer);
  const signature = ethUtil.toRpcSig(vrs.v, vrs.r, vrs.s);

  return signature;
};

export default signTransfer;

import Turbolinks from "turbolinks";
import Rails from "rails-ujs";
import { Buffer } from "buffer";
import ethUtil from "ethereumjs-util";

import "./index.css.scss";

Turbolinks.start();
Rails.start();

const tokenAddress = "0x0dcd2f752394c41875e259e00bb44fd505297caf";
const nonce = 32;
// const from = "0x1B3c50fb04F1bf4CbA7031540A49BBC0f29865C9";
const to = "0xaa181C6222bfE2B2126D90588ae53c9397957a52";
const fee = 10;
const amount = 100;
const alicePrivateKey = Buffer.from(
  "168a4439c53898b53e5243d260fc1bef18bf5cc252266dfbf06ca4c12b20034c",
  "hex"
);

const formattedAddress = address =>
  Buffer.from(ethUtil.stripHexPrefix(address), "hex");
const formattedInt = int => ethUtil.setLengthLeft(int, 32);
// const formattedBytes32 = bytes => {
// return ethUtil.addHexPrefix(bytes.toString("hex"));
// };
const hashedTightPacked = args => ethUtil.sha3(Buffer.concat(args));

const components = [
  /* "48664c16": transferPreSignedHashing(address,address,address,uint256,uint256,uint256) */
  Buffer.from("48664c16", "hex"),
  formattedAddress(tokenAddress),
  formattedAddress(to),
  formattedInt(amount),
  formattedInt(fee),
  formattedInt(nonce)
];
const vrs = ethUtil.ecsign(hashedTightPacked(components), alicePrivateKey);
const signature = ethUtil.toRpcSig(vrs.v, vrs.r, vrs.s);

console.log(signature);

import hash from "hash.js";
import BN from "bn.js";

export const STRIDE = 8n;
export const NUM_STRIDES = 256n / STRIDE; // = 32
export const REGISTERS = 4n;

export const BASE_R_SECP256K1_TEMPLATE = {
  type: "short",
  prime: "k256",
  p: "ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff fffffffe fffffc2f",
  a: "0",
  b: "7",
  n: "ffffffff ffffffff ffffffff fffffffe baaedce6 af48a03b bfd25e8c d0364141",
  h: "1",
  hash: hash.sha256,
  gRed: false,
  g: [
    // x and y coordinates of the generator point which is the point R in our case
  ]
};

export const SECP256K1_N = new BN(
  "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141",
  16
);

const { REGISTERS } = require("./config");

export const addHexPrefix = (str: string): string => `0x${str}`;

export const splitToRegisters = (value: bigint): bigint[] => {
  const registers = [];

  if (!value) {
    return [0n, 0n, 0n, 0n];
  }

  const hex = value.toString(16).padStart(64, "0");
  for (let k = 0; k < REGISTERS; k++) {
    // 64bit = 16 chars in hex
    const val = hex.slice(k * 16, (k + 1) * 16);

    registers.unshift(BigInt(addHexPrefix(val)));
  }

  return registers;
};

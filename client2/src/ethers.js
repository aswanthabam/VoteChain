import * as ethers from 'ethers';
import { pbkdf2Sync } from "react-native-quick-crypto";

ethers.pbkdf2.register(
  (
    password:Uint8Array,
    salt: Uint8Array,
    iterations: number,
    keylen: Number,
    algo: 'sha256' | 'sha512'
    // eslint-disable-next-line max-params
  ) => {
    return ethers.hexlify(pbkdf2Sync(password, salt, iterations, keylen, algo));
  }
);

export * from 'ethers';
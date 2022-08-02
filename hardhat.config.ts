import "@nomiclabs/hardhat-solhint";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {compilers: [
    {
        version: "0.6.11"
    },
    {
        version: "0.8.9"
    }
  ]
  }
};

export default config;

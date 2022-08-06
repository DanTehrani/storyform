import "dotenv/config";
import "@nomiclabs/hardhat-solhint";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "./tasks/add-member";
import "./tasks/create-group";
import "./tasks/get-members";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.6.11"
      },
      {
        version: "0.8.9"
      }
    ]
  },
  networks: {
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}`,
      // @ts-ignore
      accounts: [process.env.WALLET_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  }
};

export default config;

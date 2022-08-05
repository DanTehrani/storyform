import "@nomiclabs/hardhat-solhint";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "./tasks/add-member";

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
    arbitrum: {
      url: "https://arbitrumrpc.com",
      accounts: []
    },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/PT2E3_7VyBJKUCSi_46fGUjKO0bC0auG"
    }
    /*
    hardhat: {
      forking: {
        url: "https://eth-goerli.g.alchemy.com/v2/PT2E3_7VyBJKUCSi_46fGUjKO0bC0auG"
        //        blockNumber: 6976744
      },
      allowUnlimitedContractSize: true
    }
    */
  },
  etherscan: {
    apiKey: "8YHC8V5XKJCHE8QDU4I8ZD7JW773Z6GNCJ"
  }
};

export default config;

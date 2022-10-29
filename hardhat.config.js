require('@nomicfoundation/hardhat-toolbox')

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.4",
  networks: {
    hardhat: {
      forking: {
        url: "https://evm-t3.cronos.org/",
        chainID: 338
      }
    },
    localhost: {
      url: "https://evm-t3.cronos.org/:8545",

      accounts: ["0x27c7b4ad4bea56a04722971eaea988bebc039ad8137ecd4e59acf62244874aa2"],
      chainID: 338
    },
    cronos: {
      url: "https://evm-t3.cronos.org/",
      chainID: 338,
      accounts: ["27c7b4ad4bea56a04722971eaea988bebc039ad8137ecd4e59acf62244874aa2"],
      gasPrice: 5000000000000

    }
  },
}
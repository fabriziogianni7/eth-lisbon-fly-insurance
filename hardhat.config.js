require('@nomicfoundation/hardhat-toolbox')

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    testnet: {
      url: 'https://evm-t3.cronos.org/',
      accounts: process.env.PRIVATE_KEY,
    },
  },
  defaultNetwork: 'testnet',
  solidity: '0.8.4',
}

// const config: HardhatUserConfig = {
//   solidity: "0.8.4",
//   networks: {
//     hardhat: {
//       forking: {
//         url: process.env.KOVAN_URL || ""
//       }
//     },
//     kovan: {
//       url: process.env.KOVAN_URL || "",
//       accounts:
//         process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
//     },
//   },
//   gasReporter: {
//     enabled: process.env.REPORT_GAS !== undefined,
//     currency: "USD",
//   },
//   etherscan: {
//     apiKey: process.env.ETHERSCAN_API_KEY,
//   },
// };

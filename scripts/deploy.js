// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  try {
  const USDC_ADDRESS = "0xDc9AE3AE3Ec8acA2768e1690DD20c76942552Fcf"
console.log(process.env.PRIVATE_KEY)
  const Broker = await hre.ethers.getContractFactory("Broker");
  const broker = await Broker.deploy(USDC_ADDRESS, 'Broker', 'IBC');

  await broker.deployed();

  console.log(
     `Broker contract deployed on ${broker.address}`
  );
    
  } catch (error) {
    console.log(error )
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

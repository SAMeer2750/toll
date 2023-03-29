const { ethers } = require("hardhat");
const hre = require("hardhat");

const main = async () => {
  const toll = await ethers.getContractFactory("toll");
  const Toll = await toll.deploy();
  await Toll.deployed();
  console.log(`contract is deloyed at: ${Toll.address}`);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

import { poseidon_gencontract as poseidonContract } from "circomlibjs";
import { ethers } from "hardhat";
import { Identity } from "@semaphore-protocol/identity";
import { GROUP_ID, GROUP_DEPTH, SEMAPHORE_ADDRESS } from "../config";

async function main() {
  const Storyform = await ethers.getContractFactory("Storyform");
  const storyform = await Storyform.deploy(
    storyformVerifier.address,
    SEMAPHORE_ADDRESS
  );

  await storyform.deployed();

  console.log(`Deployed StoryForm to ${storyform.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error);
  process.exitCode = 1;
});

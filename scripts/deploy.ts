import { ethers } from "hardhat";

async function main() {
  const Verifier = await ethers.getContractFactory("Verifier");
  const verifier = await Verifier.deploy();
  await verifier.deployed();

  const SemaphoreVerifier = await ethers.getContractFactory("SemaphoreVerifier16");

  const semaphoreVerifier = await SemaphoreVerifier.deploy();
  await semaphoreVerifier.deployed();


  console.log(`Deployed SemaphoreVerifier to: ${semaphoreVerifier.address}`)

  const StoryForm = await ethers.getContractFactory("StoryForm");
  const storyForm = await StoryForm.deploy(verifier.address, semaphoreVerifier.address);
  await storyForm.deployed();

  console.log(`Deployed StoryForm to: ${storyForm.address}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

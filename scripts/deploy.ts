import { poseidon_gencontract as poseidonContract } from "circomlibjs";
import { ethers } from "hardhat";
import { Identity } from "@semaphore-protocol/identity";
import { GROUP_ID, GROUP_DEPTH } from "../config";

async function main() {
  // First, deploy the following libraries
  // - PoseidonT3
  // - IncrementalBinaryTree
  const poseidonABI = poseidonContract.generateABI(2);
  const poseidonBytecode = poseidonContract.createCode(2);

  const [signer] = await ethers.getSigners();

  const PoseidonLibFactory = new ethers.ContractFactory(
    poseidonABI,
    poseidonBytecode,
    signer
  );
  const poseidonLib = await PoseidonLibFactory.deploy();
  await poseidonLib.deployed();

  const IncrementalBinaryTreeLibFactory = await ethers.getContractFactory(
    "IncrementalBinaryTree",
    {
      libraries: {
        PoseidonT3: poseidonLib.address
      }
    }
  );
  const incrementalBinaryTreeLib =
    await IncrementalBinaryTreeLibFactory.deploy();
  await incrementalBinaryTreeLib.deployed();

  const SemaphoreVerifier = await ethers.getContractFactory(
    "SemaphoreVerifier16"
  );
  const semaphoreVerifier = await SemaphoreVerifier.deploy();
  await semaphoreVerifier.deployed();

  const Verifier = await ethers.getContractFactory("Verifier");
  const verifier = await Verifier.deploy();
  await verifier.deployed();

  const StoryForm = await ethers.getContractFactory("StoryForm", {
    libraries: {
      IncrementalBinaryTree: incrementalBinaryTreeLib.address
    }
  });
  const storyForm = await StoryForm.deploy(
    verifier.address,
    semaphoreVerifier.address
  );
  await storyForm.deployed();

  console.log(`Deployed StoryForm to ${storyForm.address}`);

  // Create group

  // Add members to group
  const createGroupTx = await storyForm.createGroup(GROUP_ID, GROUP_DEPTH);
  await createGroupTx.wait();

  const identity = new Identity("secret");

  const addMemberTx = await storyForm.addMember(
    GROUP_ID,
    identity.generateCommitment()
  );

  await addMemberTx.wait();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch(error => {
  console.error(error);
  process.exitCode = 1;
});

import { task } from "hardhat/config";
import { GROUP_ID, STORY_FORM_ADDRESS } from "../config";

task("addMember")
  .addParam("ic", "identityCommitment")
  .setAction(async ({ ic }, { ethers, network }) => {
    const contract = await ethers.getContractAt(
      "StoryForm",
      STORY_FORM_ADDRESS[network.name]
    );

    const tx = await contract.addMember(GROUP_ID, ic);
    await tx.wait();
    console.log(`Added identityCommitment ${ic}`);
    console.log(tx);
  });

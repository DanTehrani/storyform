import { task } from "hardhat/config";
import { STORY_FORM_ADDRESS } from "../config";

task("createGroup")
  .addParam("id", "groupId")
  .addParam("depth", "depth")
  .setAction(async ({ id, depth }, { ethers, network }) => {
    const contract = await ethers.getContractAt(
      "StoryForm",
      STORY_FORM_ADDRESS[network.name]
    );

    const tx = await contract.createGroup(id, depth);
    await tx.wait();
    console.log(`Crated group ${id}`);
    console.log(tx);
  });

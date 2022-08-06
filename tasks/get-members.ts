import { task } from "hardhat/config";
import { GROUP_ID, STORY_FORM_ADDRESS } from "../config";

task("getMembers")
  .addParam("gid", "groupId")
  .setAction(async ({ gid }, { ethers }) => {
    const contract = await ethers.getContractAt(
      "StoryForm",
      STORY_FORM_ADDRESS
    );

    const events = await contract.queryFilter(
      contract.filters.MemberAdded(gid, null, null)
    );

    console.log(await contract.getRoot(BigInt(GROUP_ID)));

    const members = events.map(({ args }) => args[1].toString());
    console.log(`members ${members}`);
  });

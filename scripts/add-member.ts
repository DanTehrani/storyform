import { ethers } from "hardhat";
import { GROUP_ID, STORY_FORM_ADDRESS } from "../config";

const identityCommitment =
  //  11618881449248717283353755853093036424465938758496740938503292461743485061925n;
  13029101046713966641258658025509902978734524593978465085582402600560615726088n;
//  10544751382985748449699928470939552852646287969709304050870967357218535624881n;

async function main() {
  const contract = await ethers.getContractAt("StoryForm", STORY_FORM_ADDRESS);

  const tx = await contract.addMember(GROUP_ID, identityCommitment);
  console.log(tx);
}

main();

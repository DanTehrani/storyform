import { ethers } from "hardhat";
import { packToSolidityProof } from "@semaphore-protocol/proof"

const dataSubmissionProof = {
    "proof": {
        "pi_a": [
            "20448782875721165881615635569312628715553215531430412022963918410709477969577",
            "8985962721840697248063975034359072246600139103393807041552156410426054425009",
            "1"
        ],
        "pi_b": [
            [
                "1530314215234494489871019960109506772548764435876995150816870718774871626177",
                "18939656731046642411876037665959701666538481418136736319630503333484722826008"
            ],
            [
                "12153302690580248242898112092525761689967079718302512047248248872266437942716",
                "9272749880709149546290360639870130710101519984022243614738683131604714832644"
            ],
            [
                "1",
                "0"
            ]
        ],
        "pi_c": [
            "9967615184052094574415870191091247647631865948535144103573184241838127664766",
            "5012819829932354707835764619184712186570609263751614352589848671287410069921",
            "1"
        ],
        "protocol": "groth16",
        "curve": "bn128"
    },
    "publicSignals": [
        "221044045721247054735963361366265662139826845557157969445690460755989975357",
        "21366950443399913797003062256917719955403744997431793631854879491841253767575"
    ]
}


async function main() {
    const groupId = 0;
    const StoryForm = await ethers.getContractFactory("StoryForm");
    const storyForm = await StoryForm.attach(
        "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0");

    const solidityDataSubmissionProof = packToSolidityProof(dataSubmissionProof.proof)
    const transaction = await storyForm.veirfyProof(BigInt(dataSubmissionProof.publicSignals[0]), groupId, BigInt(dataSubmissionProof.publicSignals[1]), solidityDataSubmissionProof, solidityDataSubmissionProof)
    const transactionReceipt = await transaction.wait();
    console.log(transactionReceipt)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    process.exitCode = 1;
});
  

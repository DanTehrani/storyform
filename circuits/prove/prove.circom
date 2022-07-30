include "../../node_modules/circomlib/circuits/poseidon.circom";
include "./tree.circom";

/* 
1. Prove knowledge of data pre-image
2. Prove membership
*/
template Prove(nLevels) {
    signal input secret; // Signature
    signal input formId; // 
    signal input submissionId; // submissionId
    signal input treePathIndices[nLevels];
    signal input treeSiblings[nLevels];
    signal input merkleRoot;

    component hasher = Poseidon(2);
    hasher.inputs[0] <== secret;
    hasher.inputs[1] <== formId;

    log(hasher.out);
    hasher.out === submissionId;

    component identity = Poseidon(1);
    identity.inputs[0] <== secret;

    log(identity.out);

    // Proof of inclusion
    component inclusionProof = MerkleTreeInclusionProof(3);
    inclusionProof.leaf <== identity.out;

    for (var i = 0; i < nLevels; i++) {
        inclusionProof.siblings[i] <== treeSiblings[i];
        inclusionProof.pathIndices[i] <== treePathIndices[i];
    }

    log(inclusionProof.root);
    inclusionProof.root === merkleRoot;
    // Check root validity
}

component main{ public [formId, submissionId, merkleRoot]} = Prove(3); // 586 = 256 + 74 + 256
include "../../node_modules/circomlib/circuits/poseidon.circom";

/* 
1. Prove knowledge of data pre-image
2. Prove membership
*/
template Prove() {
    signal input secret; // Signature
    signal input formId; // 
    signal input submissionId; // submissionId

    component hasher = Poseidon(2);
    hasher.inputs[0] <== secret;
    hasher.inputs[1] <== formId;

    log(hasher.out);
    hasher.out === submissionId;

    component identity = Poseidon(1);
    identity.inputs[0] <== secret;

    log(identity.out);
}

component main{ public [formId, submissionId]} = Prove(); 
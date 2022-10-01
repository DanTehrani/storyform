pragma circom 2.0.2;
include "../node_modules/circomlib/circuits/poseidon.circom";

template ProofOfSubmission() {
    signal input nullifier;
    signal input nullifierHash;
    signal input formId;
    signal input submissionHash; // submissionId

    component hasher1 = Poseidon(2);
    hasher1.inputs[0] <== nullifier;
    hasher1.inputs[1] <== formId;

    hasher1.out === submissionHash;

    component hasher2 = Poseidon(1);
    hasher2.inputs[0] <== nullifier;

    hasher2.out === nullifierHash;
}

component main { public [nullifierHash, formId, submissionHash]} = ProofOfSubmission();

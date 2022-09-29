pragma circom 2.0.2;

template ProofOfSubmissionOwnership() {
    signal input secret;
    signal input formId; 
    signal input submissionHash; // submissionId

    component poseidon = Poseidon(2);
    poseidon.inputs[0] <== secret;
    poseidon.inputs[1] <== formId;

    poseidon.out === submissionHash;
}
pragma circom 2.0.2;
include "../node_modules/circomlib/circuits/poseidon.circom";
include "tree.circom";

// Proves that the prover knows a pre-image of a hash 
// that is attathced to a membership proof
template Attestation() {
    signal input attestationHash; // submissionId
    signal input attestationHashPreImage;
    signal input messageHash; // Hash the message that the prover actually submitted.
    signal input messageHashSquared;

    component hasher = Poseidon(1);
    hasher.inputs[0] <== attestationHashPreImage;

    attestationHash === hasher.out;

    // Square the message hash to prevent message tampering.
    messageHashSquared === messageHash * messageHash;
}

component main {
    public [
        attestationHash, 
        messageHash, 
        messageHashSquared
    ]
} = Attestation();


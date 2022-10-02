pragma circom 2.0.2;
include "../node_modules/circomlib/circuits/poseidon.circom";

template AttestMembershipProof (k) {
    signal input secret[k];  // The same msg that was used to create a signature for the membership proof
    signal input hash; // This hash needs to equal to the "hash" public input of the proof of membership
    signal input msg;
    signal output msgSquared;

    component poseidon = Poseidon(k);
    for (var i = 0; i < k; i++) {
        poseidon.inputs[i] <== secret[i];
    }
    poseidon.out === hash; 

    msgSquared <== msg * msg;
}

component main { public [msg, hash] } = AttestMembershipProof(4);
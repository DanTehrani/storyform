pragma circom 2.0.2;

include "./circom-ecdsa-circuits/ecdsa.circom";
include "./circom-ecdsa-circuits/zk-identity/eth.circom";
include "./tree.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";

template FullVerifyProofOfMembership(n, k, nLevels) {
    signal input r[k];
    signal input s[k];
    signal input msg[k]; // Secret message that was signed
    signal input pubkey[2][k];
    signal input pathIndices[nLevels];
    signal input siblings[nLevels];
    signal input root;
    signal input hash;

    component poseidon = Poseidon(k);
    for (var i = 0; i < k; i++) {
        poseidon.inputs[i] <== msg[i];
    }
    poseidon.out === hash;

    component ecdsaVerify = ECDSAVerifyNoPubkeyCheck(n, k);

    for (var i = 0; i < k; i++) {
        ecdsaVerify.r[i] <== r[i];
        ecdsaVerify.s[i] <== s[i];
        ecdsaVerify.msghash[i] <== msg[i];
        ecdsaVerify.pubkey[0][i] <== pubkey[0][i];
        ecdsaVerify.pubkey[1][i] <== pubkey[1][i];
    }

    ecdsaVerify.result === 1;

    component flattenPub = FlattenPubkey(n, k);
    for (var i = 0; i < k; i++) {
        flattenPub.chunkedPubkey[0][i] <== pubkey[0][i];
        flattenPub.chunkedPubkey[1][i] <== pubkey[1][i];
    }

    component pubKeyToAddress = PubkeyToAddress();

    component pubToAddr = PubkeyToAddress();
    for (var i = 0; i < 512; i++) {
        pubToAddr.pubkeyBits[i] <== flattenPub.pubkeyBits[i];
    }


    component inclusionProof = MerkleTreeInclusionProof(nLevels);
    inclusionProof.leaf <== pubToAddr.address;

    for (var i = 0; i < nLevels; i++) {
        inclusionProof.pathIndices[i] <== pathIndices[i];
        inclusionProof.siblings[i] <== siblings[i];
    }

    root === inclusionProof.root;
}

component main = FullVerifyProofOfMembership(64, 4, 10);
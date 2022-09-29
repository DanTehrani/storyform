pragma circom 2.0.6;

include "../ecdsa_verify.circom";
include "./tree.circom";

template ProofOfMembership(n, k, nLevels) {
    signal input modInvRMultPubKey2[2][k]; // -(r^-1 * pubKey2)
    signal input negMsgMultModInvR[k]; // -(msg * r^-1)
    signal input pathIndices[nLevels];
    signal input siblings[nLevels];
    signal input root;

    component ecdsaVerify = EcdsaVerify(n, k);

    for (var i = 0; i < k; i++) {
        ecdsaVerify.modInvRMultPubKey2[0][i] <== modInvRMultPubKey2[0][i];
        ecdsaVerify.modInvRMultPubKey2[1][i] <== modInvRMultPubKey2[1][i];
        ecdsaVerify.negMsgMultModInvR[i] <== negMsgMultModInvR[i];
    }

    component inclusionProof = MerkleTreeInclusionProof(nLevels);
    inclusionProof.leaf <== ecdsaVerify.addr;

    for (var i = 0; i < nLevels; i++) {
        inclusionProof.pathIndices[i] <== pathIndices[i];
        inclusionProof.siblings[i] <== siblings[i];
    }

    root === inclusionProof.root;
}
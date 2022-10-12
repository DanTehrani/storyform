pragma circom 2.0.2;
include "../node_modules/circomlib/circuits/poseidon.circom";
include "./efficient-zk-sig/ecdsa_verify_pubkey_to_addr.circom";
include "tree.circom";

// Proves that the prover knows a signature of a particualr message
// and the corresponding address is in the merkle tree
template ProofOfMembership(treeLevels, n, k) {
    signal input s[k];
    signal input TPreComputes[32][256][2][4]; // T = r^-1 * R
    signal input U[2][k]; // -(m * r^-1 * G)
    signal input pathIndices[treeLevels];
    signal input siblings[treeLevels];
    signal input merkleRoot;

    // Used for mapping the membership proof to the
    // actual message the prover wants to signal
    signal input attestationHash; 
    signal input attestationHashSquared;

    attestationHashSquared === attestationHash * attestationHash;

    component ecdsa = ECDSAVerifyPubKeyToAddr(n, k);

    var stride = 8;
    var num_strides = 32;
    for (var i = 0; i < num_strides; i++) {
        for (var j = 0; j < 2 ** stride; j++) {
            for (var l = 0; l < k; l++) {
                ecdsa.TPreComputes[i][j][0][l] <== TPreComputes[i][j][0][l];
                ecdsa.TPreComputes[i][j][1][l] <== TPreComputes[i][j][1][l];
            }
        }
    }

    for (var i = 0; i < k; i++) {
        ecdsa.s[i] <== s[i];
    }

    for (var i = 0; i < k; i++) { 
        ecdsa.U[0][i] <== U[0][i];
        ecdsa.U[1][i] <== U[1][i];
    }


    component tree = MerkleTreeInclusionProof(treeLevels);
    tree.leaf <== ecdsa.addr;

    for (var i = 0; i < treeLevels; i++) {
        tree.pathIndices[i] <== pathIndices[i];
        tree.siblings[i] <== siblings[i];
    }

    merkleRoot === tree.root;
}

component main {
    public [
        attestationHash, 
        attestationHashSquared, 
        TPreComputes, 
        U,
        merkleRoot
    ]
} = ProofOfMembership(10, 64, 4);

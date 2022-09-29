pragma circom 2.0.2;
include "./proof-of-membership/proof_of_membership.circom";
include "./proof_of_submission_ownership.circom";

template Storyform(n, k, nLevels) {
    // Inputs for proof of membership
    signal input modInvRMultPubKey2[2][k]; // -(r^-1 * pubKey2)
    signal input negMsgMultModInvR[k]; // -(msg * r^-1)
    signal input pathIndices[nLevels];
    signal input siblings[nLevels];
    signal input root;
    // Inputs for proof of submission ownership
    signal input secret; 
    signal input formId;
    signal input submissionHash;

    component proofOfMembership = ProofOfMembership(n, k, nLevels);

    for (var i = 0; i < k; i++) {
        proofOfMembership.modInvRMultPubKey2[0][i] <== modInvRMultPubKey2[0][i];
        proofOfMembership.modInvRMultPubKey2[1][i] <== modInvRMultPubKey2[1][i];
        proofOfMembership.negMsgMultModInvR[i] <== negMsgMultModInvR[i];
    }

    for (var i = 0; i < nLevels; i++) {
        proofOfMembership.pathIndices[i] <== pathIndices[i];
        proofOfMembership.siblings[i] <== siblings[i];
    }

    proofOfMembership.root <== root;

    component proofOfSubmissionOwnership = ProofOfSubmissionOwnership();

    proofOfSubmissionOwnership.submissionHash <== submissionHash;
    proofOfSubmissionOwnership.secret <== secret;
    proofOfSubmissionOwnership.formId <== formId;
}

component main { public [submissionHash, formId, root, modInvRMultPubKey2]} = Storyform(64, 4, 10);

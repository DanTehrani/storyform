pragma solidity ^0.8.9;

interface IVerifier {
    function verifyProof(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[3] memory input
    ) external view returns (bool);
}



contract StoryForm {
    IVerifier public verifier;

    event ProofVerified(uint256 indexed submissionId);

    constructor(address verifierAddress) {
       verifier = IVerifier(verifierAddress);
    }

    function veirfyProof(
        uint256[8] calldata proof,
        uint256 formId,
        uint256 submissionId,
        uint256 merkleRoot
    ) external {
        uint256[2] memory a =[proof[0], proof[1]];
        uint256[2][2] memory b = [[proof[2], proof[3]], [proof[4], proof[5]]];
        uint256[2] memory c = [proof[6], proof[7]];
        uint256[3] memory input = [formId, submissionId, merkleRoot];

        require(verifier.verifyProof(a, b, c, input) == true, "Invalid proof");
        emit ProofVerified(submissionId);
    }   
}


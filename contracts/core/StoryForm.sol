//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@semaphore-protocol/contracts/interfaces/ISemaphoreGroups.sol";
import "hardhat/console.sol";
import "../verifiers/StoryformVerifier.sol";

// Using Semaphore only for managing groups. Not using Semaphore circuits.
contract Storyform is StoryformVerifier {
  ISemaphoreGroups public semaphore;

  event SubmissionProofVerified(
    uint256 indexed submissionId,
    uint256 indexed groupId
  );

  constructor(address semaphoreAddress) {
    semaphore = ISemaphoreGroups(semaphoreAddress);
  }

  // Verify submission proof
  function verifyProof(
    uint256 formId,
    uint256 groupId,
    uint256 submissionId,
    uint256[8] calldata submissionProof
  ) external {
    require(
      _verifyProof(formId, groupId, submissionId, submissionProof),
      "Invalid proof"
    );
    emit SubmissionProofVerified(submissionId, groupId);
  }
}

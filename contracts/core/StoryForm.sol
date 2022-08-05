//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;
import "@semaphore-protocol/contracts/interfaces/IVerifier.sol";
import "@semaphore-protocol/contracts/base/SemaphoreCore.sol";
import "@semaphore-protocol/contracts/base/SemaphoreGroups.sol";
import "hardhat/console.sol";

interface IStoryFormVerifier {
  function verifyProof(
    uint256[2] memory a,
    uint256[2][2] memory b,
    uint256[2] memory c,
    uint256[2] memory input
  ) external view returns (bool);
}

contract StoryForm is SemaphoreCore, SemaphoreGroups {
  IStoryFormVerifier public storyFormVerifier;
  IVerifier public semaphoreVerifier;

  uint256 constant semaphoreConstantNullifierHash = 0;
  bytes32 constant semaphoreConstantSignal = "0";

  event ProofVerified(uint256 indexed submissionId, uint256 indexed groupId);
  mapping(uint256 => uint256) blockHeightToMerkleRoot;
  address[] members; // Store the

  constructor(
    IStoryFormVerifier _storyFormVerifier,
    IVerifier _semaphoreVerifier
  ) {
    storyFormVerifier = _storyFormVerifier;
    semaphoreVerifier = _semaphoreVerifier;
  }

  function _verifyMembershipProof(
    uint256 groupId,
    uint256 nullifierHash,
    uint256[8] calldata proof
  ) internal view {
    uint256 root = groups[groupId].root;

    _verifyProof(
      semaphoreConstantSignal,
      root,
      nullifierHash,
      groupId,
      proof,
      semaphoreVerifier
    );
  }

  function _verifyDataOwnershipProof(
    uint256 formId,
    uint256 submissionId,
    uint256[8] calldata proof
  ) internal view {
    // Verify data ownership proof
    uint256[2] memory a = [proof[0], proof[1]];
    uint256[2][2] memory b = [[proof[2], proof[3]], [proof[4], proof[5]]];
    uint256[2] memory c = [proof[6], proof[7]];
    uint256[2] memory input = [formId, submissionId];
    require(
      storyFormVerifier.verifyProof(a, b, c, input) == true,
      "Invlid dataownership proof"
    );
  }

  // Probably need to pass merkle root as the arguemnt
  function verifyProof(
    uint256 formId,
    uint256 groupId,
    uint256 submissionId,
    uint256 nullifierHash,
    uint256[8] calldata membershipProof,
    uint256[8] calldata submissionOwnershipProof
  ) external {
    _verifyMembershipProof(groupId, nullifierHash, membershipProof);
    _verifyDataOwnershipProof(formId, submissionId, submissionOwnershipProof);

    emit ProofVerified(submissionId, groupId);
  }

  function createGroup(uint256 groupId, uint8 depth) external {
    _createGroup(groupId, depth, 0);
  }

  function addMember(uint256 groupId, uint256 identityCommitment) external {
    _addMember(groupId, identityCommitment);
  }
}

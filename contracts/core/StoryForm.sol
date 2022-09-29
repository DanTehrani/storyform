//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@semaphore-protocol/contracts/interfaces/IVerifier.sol";
import "hardhat/console.sol";
import "./ECDSAMembershipManager.sol";

interface IStoryFormVerifier {
  function verifyProof(
    uint256[2] memory a,
    uint256[2][2] memory b,
    uint256[2] memory c,
    uint256[2] memory input
  ) external view returns (bool);
}

contract StoryForm is ECDSAMembershipManager {
  IStoryFormVerifier public storyFormVerifier;
  IECDSAMembershipVerifier public ecdsaMembershipVerifier;
  IDeployedSemaphore public semaphore;

  uint256 constant semaphoreConstantNullifierHash = 0;
  bytes32 constant semaphoreConstantSignal = "0";

  event ProofVerified(uint256 indexed submissionId, uint256 indexed groupId);

  constructor(
    address storyFormVerifierAddress,
    address ecdsaMembershipVerifierAddress,
    address semaphoreAddress
  ) {
    storyFormVerifier = IStoryFormVerifier(storyFormVerifierAddress);
    ecdsaMembershipVerifier = IECDSAMembershipVerifier(
      ecdsaMembershipVerifierAddress
    );
    semaphore = IDeployedSemaphore(semaphoreAddress);
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

  // Verify both submission ownership proof and group membership proof
  function verifyProof(
    uint256 formId,
    uint256 groupId,
    uint256 submissionId,
    uint256[8] calldata membershipProof,
    uint256[8] calldata submissionOwnershipProof
  ) external {
    require(
      _veirfyECDSAMembership(
        groupId,
        membershipProof,
        ecdsaMembershipVerifier,
        semaphore
      )
    );
    _verifyDataOwnershipProof(formId, submissionId, submissionOwnershipProof);

    emit ProofVerified(submissionId, groupId);
  }
}

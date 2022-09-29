// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@semaphore-protocol/contracts/base/SemaphoreCore.sol";
import "@semaphore-protocol/contracts/interfaces/ISemaphoreGroups.sol";
import "@semaphore-protocol/contracts/interfaces/ISemaphore.sol";

interface IECDSAMembershipVerifier {
  function verifyProof(
    uint256[2] memory a,
    uint256[2][2] memory b,
    uint256[2] memory c,
    uint256[2] memory input
  ) external view returns (bool);
}

interface IDeployedSemaphore is ISemaphore, ISemaphoreGroups {}

// Efficienty verifies ECDSA signatures and membership proofs (merkle proofs)
// Manage ECDSA groups
contract ECDSAMembershipManager {
  function _veirfyECDSAMembership(
    uint256 groupId,
    uint256[8] calldata ecdsaMembershipProof,
    IECDSAMembershipVerifier ecdsaMembershipVerifier,
    IDeployedSemaphore semaphore
  ) public view returns (bool) {
    uint256 merkleRoot = semaphore.getMerkleTreeRoot(groupId);

    return
      ecdsaMembershipVerifier.verifyProof(
        [ecdsaMembershipProof[0], ecdsaMembershipProof[1]],
        [
          [ecdsaMembershipProof[2], ecdsaMembershipProof[3]],
          [ecdsaMembershipProof[4], ecdsaMembershipProof[5]]
        ],
        [ecdsaMembershipProof[6], ecdsaMembershipProof[7]],
        [groupId, merkleRoot]
      );
  }

  function createGroup(
    uint256 groupId,
    uint8 depth,
    IDeployedSemaphore semaphore
  ) public {
    semaphore.createGroup(groupId, depth, 0, msg.sender);
  }

  // Addresses as integers
  function addMembers(
    uint256 groupId,
    uint256[] calldata addresses,
    IDeployedSemaphore semaphore
  ) public {
    semaphore.addMembers(groupId, addresses);
  }
}

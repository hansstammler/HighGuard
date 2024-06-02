// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Governance {
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCount;
        uint256 startTime;
        uint256 reviewEndTime;
        uint256 votingEndTime;
        uint256 executionTime;
        bool isExecuted;
        uint256 voteThreshold;
    }

    uint256 public reviewDuration = 5 seconds;
    uint256 public votingDuration = 5 seconds;
    uint256 public gracePeriod = 5 seconds;
    uint256 public defaultVoteThreshold = 3; // Default voting threshold

    address public privilegedAddress =
        0x1234567890abcdef1234567890abcdef12345678; // Set a specific privileged address

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public votes; // Tracks if an address has voted on a proposal
    uint256 public nextProposalId;

    function createProposal() public returns (uint256) {
        Proposal storage p = proposals[nextProposalId];
        p.id = nextProposalId;
        p.description = "dummy description";
        p.startTime = block.timestamp;
        p.reviewEndTime = block.timestamp + reviewDuration;
        p.votingEndTime = p.reviewEndTime + votingDuration;
        p.executionTime = p.votingEndTime + gracePeriod;
        p.voteThreshold = defaultVoteThreshold;
        nextProposalId++;
        return nextProposalId;
    }

    function vote(uint256 proposalId) public {
        require(
            block.timestamp >= proposals[proposalId].reviewEndTime,
            "Review period is not over"
        );
        require(
            block.timestamp <= proposals[proposalId].votingEndTime,
            "Voting period is over"
        );
        require(!votes[proposalId][msg.sender], "Already voted");

        proposals[proposalId].voteCount += 1;
        votes[proposalId][msg.sender] = true;
    }

    function executeProposal(uint256 proposalId) public {
        Proposal storage p = proposals[proposalId];

        require(block.timestamp >= p.executionTime, "Grace period is not over");

        // Allow changing vote threshold if executed by privileged address
        if (msg.sender == privilegedAddress) {
            p.voteThreshold = 1; // Lowering the vote threshold
        }

        require(p.voteCount >= p.voteThreshold, "Votes below threshold");
        require(!p.isExecuted, "Proposal already executed");

        p.isExecuted = true;
    }
}

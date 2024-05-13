// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SimpleGovernance {
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCount;
        uint256 startTime;
        uint256 reviewEndTime;
        uint256 votingEndTime;
        uint256 executionTime;
        bool isExecuted;
    }

    uint256 public reviewDuration = 3 days;
    uint256 public votingDuration = 5 days;
    uint256 public gracePeriod = 2 days;
    uint256 public voteThreshold = 10; // Arbitrary threshold

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public votes; // Tracks if an address has voted on a proposal
    uint256 public nextProposalId;

    function createProposal() public {
        Proposal storage p = proposals[nextProposalId];
        p.id = nextProposalId;
        p.description = "Sample proposal";
        p.startTime = block.timestamp;
        p.reviewEndTime = block.timestamp + reviewDuration;
        p.votingEndTime = p.reviewEndTime + votingDuration;
        p.executionTime = p.votingEndTime + gracePeriod;
        nextProposalId++;
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
        require(p.voteCount >= voteThreshold, "Votes below threshold");
        require(!p.isExecuted, "Proposal already executed");

        p.isExecuted = true;
        // Execute the proposal logic here (e.g., change contract state)
    }
}

pragma solidity ^0.8.0;

contract MultiStageAuction {
    enum AuctionPhase {
        Commit,
        Reveal,
        Ended
    }

    AuctionPhase public currentPhase = AuctionPhase.Commit;

    mapping(address => bytes32) public commitments;
    mapping(address => uint256) public revealedBids;
    address public highestBidder;
    uint256 public highestBid;

    function commitBid(bytes32 hashedBid) public {
        // Vulnerability: Allows bid commitments even in the Reveal phase
        require(
            currentPhase == AuctionPhase.Commit ||
                currentPhase == AuctionPhase.Reveal,
            "Cannot commit at this phase."
        );
        commitments[msg.sender] = hashedBid;
    }

    function revealBid(uint256 amount, string memory secret) public {
        require(currentPhase == AuctionPhase.Reveal, "Not in Reveal Phase.");
        bytes32 hashedBid = keccak256(
            abi.encodePacked(uint256ToString(amount), secret)
        );
        require(commitments[msg.sender] == hashedBid, "Invalid bid revealed.");
        revealedBids[msg.sender] = amount;

        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    function endAuction() public {
        require(
            currentPhase == AuctionPhase.Reveal,
            "Auction not in reveal phase."
        );
        currentPhase = AuctionPhase.Ended;
    }

    function getHashFromInput(
        uint256 amount,
        string memory secret
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(uint256ToString(amount), secret));
    }

    function uint256ToString(
        uint256 value
    ) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}

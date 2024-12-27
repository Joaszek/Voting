// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {
    address owner;
    struct Candidate {
        string name;
        uint8 voteAmount;
    }
    mapping(address => bool) hasVoted;
    Candidate[] candidates;

    constructor() {
        owner = msg.sender;
    }

    function addNewCandidate(string memory _name) public {
        require(msg.sender == owner, "You are not the owner");
        for( uint8 i = 0;i<candidates.length;i++) {
            if (keccak256(abi.encodePacked(candidates[i].name)) == keccak256(abi.encodePacked(_name))) {
                revert("Candidate already exists");
            }
        }
        candidates.push(Candidate({name: _name, voteAmount: 0}));
    }
    
    function vote(string memory _name) public {
        require(!hasVoted[msg.sender], "You have already voted");
        for (uint8 i = 0;i<candidates.length;i++) {
            if (keccak256(abi.encodePacked(candidates[i].name)) == keccak256(abi.encodePacked(_name))) {
                candidates[i].voteAmount++;
                hasVoted[msg.sender] = true;
            }
        }
    }

    function getCandidateVotes(string memory _name) public view returns(uint8){
        for (uint8 i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i].name)) == keccak256(abi.encodePacked(_name))) {
                return candidates[i].voteAmount;
            }
        }
        return 0;
    }
}
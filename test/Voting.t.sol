// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {Voting} from "../src/Voting.sol";

contract TestVoting is Test {

    Voting voting;

    function setUp() public {
        voting = new Voting();
        voting.addNewCandidate("Alice");
    }

    function testInitialVotes() public view {
        uint8 initialVotes = voting.getCandidateVotes("Alice");
        assertEq(initialVotes, 0);
    }

    function testVote() public {
        voting.vote("Alice");
        uint8 votes = voting.getCandidateVotes("Alice");
        assertEq(votes, 1);
    }

    function testAddNewCandidate() public {
        voting.addNewCandidate("Bob");
        uint8 votes = voting.getCandidateVotes("Bob");
        assertEq(votes, 0);
    }

    function testAddNewCandidateNotOwner() public {
        vm.prank(address(1));
        vm.expectRevert("Only owner can add new candidate");
        voting.addNewCandidate("Bob");
    }

    function testVoteMultipleTimes() public {
        voting.vote("Alice");
        vm.expectRevert("You have already voted");
        voting.vote("Alice");
    }

    function testAddingForNotOwner() public {
        vm.prank(address(1));
        vm.expectRevert("Only owner can add new candidate");
        voting.addNewCandidate("Bob");
    }
}
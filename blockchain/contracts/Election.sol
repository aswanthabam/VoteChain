// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.16;

contract Election {
    constructor() public {}

    // STRUCTURES

    // Candidate Structure
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    // An Entity of election structure
    struct ElectionEntity {
        uint id;
        string name;
        Candidate[] candidates;
        bool started;
        bool ended;
    }
    // User structure
    struct User {
        uint uid;
        address _address;
        string name;
    }

    // EVENTS

    // Event : USER Registered
    event UserRegisteredEvent(address _address);

    // MAPPINGS

    // User related
    mapping(address => User) public users; // get user by the address
    mapping(uint => bool) private isRegistered; // userId and all registered users
    mapping(address => bool) private isAddressUsed; // for checking if an address is already registered
    mapping(address => bool) public verified; // for checking if a user is verified
    // election realted
    mapping(uint => ElectionEntity) public elections; // All Election Entities
    mapping(address => ElectionEntity[]) public allowedElections; // Get allowed election to vote of a voter
    mapping(address => uint) public allowedElectionsCount;

    // FUNCTIONS

    // Function to register  user
    function registerUser(uint uid, string memory _name) public {
        require(!isRegistered[uid], "Already registered"); // The uid is not registered
        require(!isAddressUsed[msg.sender], "Address Already Used"); // The address is not used

        users[msg.sender] = User(uid, msg.sender, _name);
        isRegistered[uid] = true;
        isAddressUsed[msg.sender] = true;
        emit UserRegisteredEvent(msg.sender);
    }

    // verify a user
    function verifyUser(address user, uint uid) public {
        require(isRegistered[uid], "UID Not registered");
        require(users[user].uid == uid, "Address Missmatch");

        verified[user] = true;
    }

    // approve a user to vote on a perticular election
    function approveToVote(address user, uint uid, uint electionId) public {
        require(isRegistered[uid], "UID Not registered");
        require(users[user].uid == uid, "Address Missmatch");
        require(elections[electionId].started, "ElectionEntity doesnt exist");

        allowedElections[user][allowedElectionsCount[user]] = elections[
            electionId
        ];
        allowedElectionsCount[user]++;
    }
}

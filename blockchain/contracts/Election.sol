// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.16;

contract Election {
    // VARIABLES
    address admin;
    uint electionCount = 0;
    uint candidatesCount = 0;
    uint requestCount = 0;

    constructor() public {
        admin = msg.sender; // Deployer is the admin
    }

    // STRUCTURES

    // Candidate Structure
    struct Candidate {
        uint id;
        address candidateAddress;
        string name;
        uint voteCount;
        uint uid;
    }
    // Election Candidate Participation Request
    struct ParticipationRequest {
        uint id;
        address from;
        string name;
        uint uid;
        uint electionId;
        bool approved;
    }
    // An Entity of election structure
    struct ElectionEntity {
        uint id;
        string name;
        bool started;
        bool ended;
        bool accept_request;
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
    event ElectionCreatedEvent(uint electionId, string name);
    event CandidateAddedEvent(uint candidateId, string name);
    event ParticipationRequestEvent(uint requestId);
    event ApprovedParticipationRequest(uint candidateId);
    // MAPPINGS

    // User related
    mapping(address => User) public users; // get user by the address
    mapping(uint => bool) private isRegistered; // userId and all registered users
    mapping(address => bool) private isAddressUsed; // for checking if an address is already registered
    mapping(address => bool) public verified; // for checking if a user is
    // Election related
    mapping(uint => ElectionEntity) public elections; // All Election Entities
    mapping(address => ElectionEntity[]) public allowedElections; // Get allowed election to vote of a voter
    mapping(address => uint) public allowedElectionsCount; // No of allowed elections to vote of a user
    // Candidate related
    // mapping(address => Candidate) public candidates; // All candidates and their address
    mapping(uint => Candidate[]) public candidates; // Candidates in an election entity
    mapping(address => ParticipationRequest[]) public participationRequests; // All participation requests of a person
    mapping(uint => ParticipationRequest) public allParticipationRequests; // All participation request

    // MODIFIERS

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this operation");
        _;
    }

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

    // add an election
    function addElectionEntity(string memory name) public onlyAdmin {
        electionCount++;
        elections[electionCount] = ElectionEntity(
            electionCount,
            name,
            false,
            false,
            false
        );
        emit ElectionCreatedEvent(electionCount, name);
    }

    // Function to request to participate in an election
    function requestToParticipate(
        uint electionId,
        uint uid,
        string memory name
    ) public {
        require(elections[electionId].id != 0, "Election doesnt exist");
        // Check if already requested
        ParticipationRequest[] memory requests = participationRequests[
            msg.sender
        ];
        bool tmp = true;
        for (uint256 i = 0; i < requests.length; i++) {
            if (requests[i].electionId == electionId) {
                tmp = false;
            }
        }
        require(tmp, "Already requested to participate in that election");
        requestCount++;
        participationRequests[msg.sender].push(
            ParticipationRequest(
                requestCount,
                msg.sender,
                name,
                uid,
                electionId,
                false
            )
        );
        allParticipationRequests[requestCount] = ParticipationRequest(
            requestCount,
            msg.sender,
            name,
            uid,
            electionId,
            false
        );
        emit ParticipationRequestEvent(requestCount);
    }

    // Approve a participation request
    function approveRequest(uint id) public onlyAdmin {
        require(allParticipationRequests[id].id != 0, "Request Not found");
        require(
            !allParticipationRequests[id].approved,
            "Already approved request"
        );
        ParticipationRequest memory request = allParticipationRequests[id];
        allParticipationRequests[id].approved = true;
        candidatesCount++;
        candidates[request.electionId].push(
            Candidate(
                candidatesCount,
                request.from,
                request.name,
                0,
                request.uid
            )
        );
        emit ApprovedParticipationRequest(candidatesCount);
    }
}

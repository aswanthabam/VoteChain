// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.16;

contract Election {
    constructor() public {
        admin = msg.sender; // Deployer is the admin
    }

    // VARIABLES
    address admin;
    uint public electionCount = 0;
    uint public candidatesCount = 0;
    uint public nominationRequestCount = 0;
    uint private userCount = 0;
    uint private userParticipationRequestCount = 0;
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
    struct NominationRequest {
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
        bool removed_election;
    }
    // User structure
    struct User {
        uint uid;
        address _address;
        string name;
    }
    // User Registration Request
    struct UserVerificationRequest {
        uint uid;
        address _address;
        string name;
        bool verified;
        bool rejected;
    }
    // User Election Participation Request
    struct UserElectionParticipationRequest {
        uint uid;
        uint electionId;
        bool accepted;
        bool rejected;
        string text;
    }

    // EVENTS

    // Event : USER Registered
    event UserRegisteredEvent(address _address, uint uid);
    event ElectionCreatedEvent(uint electionId, string name);
    event CandidateAddedEvent(uint candidateId, string name);
    event NominationRequestEvent(uint requestId);
    event ApprovedNominationRequest(uint candidateId);
    event VotedEvent(address to, uint uid);
    event UserVerifiedEvent(uint uid, bool status, string reason);
    event ElectionStartedEvent(uint electionId, string name);
    event ElectionEndedEvent(uint electionId, string name);
    event ElectionStartedAcceptingCandidateRequestsEvent(uint uid, string name);
    event ElectionRemovedEvent(uint uid, string name);
    event UserElectionParticipationRequestedEvent(
        uint uid,
        uint electioId,
        uint requestId
    );
    event UserReviewedParticipationRequestEvent(
        uint uid,
        uint election,
        string message
    );

    // MAPPINGS

    // User related
    mapping(address => User) public users; // get user by the address
    mapping(uint => bool) private isRegistered; // userId and all registered users
    mapping(address => bool) private isAddressUsed; // for checking if an address is already registered
    mapping(address => bool) public verified; // for checking if a user is verified
    mapping(uint => UserVerificationRequest) public userVerificationRequests; // The requestes from users to register, waiting for verification
    mapping(uint => UserElectionParticipationRequest)
        public userParticipationRequests;
    // Election related
    mapping(uint => ElectionEntity) public elections; // All Election Entities
    mapping(address => mapping(uint => ElectionEntity)) public allowedElections; // Get allowed election to vote of a voter
    mapping(address => uint) public allowedElectionsCount; // No of allowed elections to vote of a user
    // Candidate related
    mapping(uint => mapping(uint => Candidate)) public candidates; // Candidates in an election entity
    mapping(uint => uint) public numberOfCandidates; // The number of candidates in an election entity
    mapping(address => NominationRequest[]) public nominationRequests; // All participation requests of a person
    mapping(address => uint) public numberOfNominationRequests; // The number of participation requests by a person
    mapping(uint => NominationRequest) public allNominationRequests; // All participation request
    mapping(uint => uint) public nominationRequestCountOfElection; // All election count filtered by electionId
    mapping(uint => mapping(uint => NominationRequest))
        public allNominationRequestOfElection; // All participation requests filtered by electionId
    // Voting related
    mapping(address => mapping(uint => bool)) isVoted;

    // MODIFIERS

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this operation");
        _;
    }

    // FUNCTIONS
    function addElement(
        uint[] memory oldArray,
        uint value
    ) private pure returns (uint[] memory) {
        uint[] memory newArray = new uint[](oldArray.length + 1);
        for (uint i = 0; i < oldArray.length; i++) {
            newArray[i] = oldArray[i];
        }
        newArray[oldArray.length] = value;
        return newArray;
    }

    //Function to get user participation requestes
    function getUserParticipationRequests()
        public
        view
        onlyAdmin
        returns (uint[] memory)
    {
        uint count = userParticipationRequestCount;
        uint[] memory req = new uint[](0);
        // uint c = 0;
        for (uint i = 1; i <= count; i++) {
            if (
                !userParticipationRequests[i].accepted &&
                !userParticipationRequests[i].rejected
            ) {
                req = addElement(req, i);
            }
        }
        return req;
    }

    // Function to get the unverified users
    function getUserVerificationRequests()
        public
        view
        onlyAdmin
        returns (uint[] memory)
    {
        uint count = userCount;
        uint[] memory req = new uint[](0);
        // uint c = 0;
        for (uint i = 1; i <= count; i++) {
            if (
                !userVerificationRequests[i].verified &&
                !userVerificationRequests[i].rejected
            ) {
                req = addElement(req, i);
            }
        }
        return req;
    }

    // Function to register  user
    function registerUser(string memory _name) public {
        // require(!isRegistered[uid], "Already registered"); // The uid is not registered
        require(!isAddressUsed[msg.sender], "Address Already Used"); // The address is not used
        userCount++;
        uint uid = userCount;
        userVerificationRequests[uid] = UserVerificationRequest(
            uid,
            msg.sender,
            _name,
            false,
            false
        );
        isRegistered[uid] = true;
        isAddressUsed[msg.sender] = true;
        emit UserRegisteredEvent(msg.sender, uid);
    }

    // verify a user
    function verifyUser(
        address user,
        uint uid,
        bool status,
        string memory status_text
    ) public onlyAdmin {
        require(isRegistered[uid], "UID Not registered");
        require(
            userVerificationRequests[uid]._address == user,
            "User not registered or the address is mismatched"
        );
        require(!verified[user], "Already verified");

        UserVerificationRequest memory request = userVerificationRequests[uid];
        users[request._address] = User(uid, user, request.name);
        if (status) {
            verified[user] = true;
            userVerificationRequests[uid].verified = true;
        } else {
            userVerificationRequests[uid].rejected = true;
        }
        emit UserVerifiedEvent(uid, status, status_text);
    }

    function requestToParticipate(uint uid, uint electionId) public {
        require(isRegistered[uid], "UID Not registered");
        require(users[msg.sender].uid == uid, "Address Missmatched");
        require(elections[electionId].id != 0, "ElectionEntity doesnt exist");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(verified[msg.sender], "User is not verified");
        bool tmp = true;
        uint count = allowedElectionsCount[msg.sender];
        for (uint i = 0; i <= count; i++) {
            if (allowedElections[msg.sender][i].id == electionId) {
                tmp = false;
            }
        }
        require(tmp, "Already allowed");

        userParticipationRequestCount++;
        userParticipationRequests[
            userParticipationRequestCount
        ] = UserElectionParticipationRequest(uid, electionId, false, false, "");
        emit UserElectionParticipationRequestedEvent(
            uid,
            electionId,
            userParticipationRequestCount
        );
    }

    // approve a user to vote on a perticular election
    function approveToVote(
        address user,
        uint uid,
        uint electionId
    ) public onlyAdmin {
        require(isRegistered[uid], "UID Not registered");
        require(users[user].uid == uid, "Address Missmatched");
        require(elections[electionId].id != 0, "ElectionEntity doesnt exist");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(verified[user], "User is not verified");

        bool tmp = true;
        uint count = allowedElectionsCount[user];
        for (uint i = 0; i <= count; i++) {
            if (allowedElections[user][i].id == electionId) {
                tmp = false;
            }
        }
        require(tmp, "Already allowed");

        allowedElectionsCount[user]++;
        allowedElections[user][allowedElectionsCount[user]] = elections[
            electionId
        ];
    }

    // Function to start an election
    function startElection(uint electionId) public onlyAdmin {
        require(elections[electionId].id != 0, "Election not found");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(!elections[electionId].started, "Election already started");
        require(
            !elections[electionId].ended,
            "The election is ended, try restarting it"
        );

        elections[electionId].started = true;
        emit ElectionStartedEvent(electionId, elections[electionId].name);
    }

    // Function to end an election
    function endElection(uint electionId) public onlyAdmin {
        require(elections[electionId].id != 0, "Election not found");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(elections[electionId].started, "Election not started");
        require(!elections[electionId].ended, "The election is ended");

        elections[electionId].ended = true;
        emit ElectionEndedEvent(electionId, elections[electionId].name);
    }

    // Function to remove an election
    function removeElection(uint electionId) public onlyAdmin {
        require(elections[electionId].id != 0, "Election not found");
        require(
            !elections[electionId].removed_election,
            "Election already removed"
        );

        elections[electionId].removed_election = true;
        emit ElectionRemovedEvent(electionId, elections[electionId].name);
    }

    // Function to start accepting candidate requests for an election
    function startAcceptingNominationRequests(
        uint electionId
    ) public onlyAdmin {
        require(elections[electionId].id != 0, "Election not found");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(!elections[electionId].ended, "Election was ended");

        elections[electionId].accept_request = true;
        emit ElectionStartedAcceptingCandidateRequestsEvent(
            electionId,
            elections[electionId].name
        );
    }

    // add an election
    function addElectionEntity(string memory name) public onlyAdmin {
        electionCount++;
        elections[electionCount] = ElectionEntity(
            electionCount,
            name,
            false,
            false,
            false,
            false
        );
        emit ElectionCreatedEvent(electionCount, name);
    }

    // Function to request to participate in an election
    function sendNominationRequest(
        uint electionId,
        uint uid,
        string memory name
    ) public {
        require(elections[electionId].id != 0, "Election doesnt exist");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(
            elections[electionId].accept_request,
            "Not started accepting participation requests"
        );
        // Check if already requested
        NominationRequest[] memory requests = nominationRequests[msg.sender];
        bool tmp = true;
        for (uint256 i = 0; i < requests.length; i++) {
            if (requests[i].electionId == electionId) {
                tmp = false;
            }
        }
        require(tmp, "Already requested to participate in that election");
        nominationRequestCount++;
        nominationRequestCountOfElection[electionId]++;
        nominationRequests[msg.sender].push(
            NominationRequest(
                nominationRequestCount,
                msg.sender,
                name,
                uid,
                electionId,
                false
            )
        );
        allNominationRequests[nominationRequestCount] = NominationRequest(
            nominationRequestCount,
            msg.sender,
            name,
            uid,
            electionId,
            false
        );
        allNominationRequestOfElection[electionId][
            nominationRequestCountOfElection[electionId]
        ] = NominationRequest(
            nominationRequestCount,
            msg.sender,
            name,
            uid,
            electionId,
            false
        );
        numberOfNominationRequests[msg.sender]++;
        emit NominationRequestEvent(nominationRequestCount);
    }

    // Approve a participation request
    function approveNominationRequest(uint id) public onlyAdmin {
        require(allNominationRequests[id].id != 0, "Request Not found");
        require(
            !allNominationRequests[id].approved,
            "Already approved request"
        );
        NominationRequest memory request = allNominationRequests[id];
        allNominationRequests[id].approved = true;
        candidatesCount++;
        numberOfCandidates[request.electionId]++;
        candidates[request.electionId][
            numberOfCandidates[request.electionId]
        ] = Candidate(
            candidatesCount,
            request.from,
            request.name,
            0,
            request.uid
        );
        emit ApprovedNominationRequest(candidatesCount);
    }

    // vote
    function vote(
        uint uid,
        uint electionId,
        uint candidateId,
        address candidateAddress
    ) public {
        require(isRegistered[uid], "UID Not registered");
        require(users[msg.sender].uid == uid, "Address Missmatched");
        require(elections[electionId].id != 0, "ElectionEntity doesnt exist");
        require(
            !elections[electionId].removed_election,
            "Election was removed"
        );
        require(verified[msg.sender], "User is not verified");

        require(!isVoted[msg.sender][electionId], "Already voted");
        require(elections[electionId].started, "Election not started");
        require(!elections[electionId].ended, "Election ended");

        bool tmp = false;
        for (uint i = 0; i <= allowedElectionsCount[msg.sender]; i++) {
            if (allowedElections[msg.sender][i].id == electionId) {
                tmp = true;
            }
        }

        require(tmp, "Not allowed to vote in this election");

        tmp = false;
        uint canId;
        for (uint i = 0; i <= numberOfCandidates[electionId]; i++) {
            if (
                candidates[electionId][i].id == candidateId &&
                candidates[electionId][i].candidateAddress == candidateAddress
            ) {
                tmp = true;
                canId = i;
            }
        }
        require(tmp, "Invalid Candidate Details");
        candidates[electionId][canId].voteCount++;
        isVoted[msg.sender][electionId] = true;
        emit VotedEvent(candidateAddress, candidateId);
    }
}

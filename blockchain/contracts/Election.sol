// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.16;

contract Election {
    constructor() public {
        addCandidate("candidate 1");
        addCandidate("candidate 2");
    }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    struct ElectionEntity {
      uint id;
      string name;
    }
    event UserRegisteredEvent(address _address);
    struct User {
      uint uid;
      address _address;
      string name;
      bool approved;
    }
    mapping(address => User) public users;
    mapping(uint => bool) private isRegistered;
    mapping(address => bool) public approvedToVote;
    
    mapping(address => ElectionEntity) public allowedElections;
    mapping(uid => Candidate[]) public candidatesOf;
    
    function registerUser(uint uid, string memory _name) {
      require(users[msg.sender] == null); // The address is not used
      require(!isRegistered[uid]); // The uid is not registered
      users[msg.sender] = User(uid,msg.sender,_name,false);
      isRegistered[uid] = true;
      emit UserRegisteredEvent(msg.sender);
    }
    
    event VotedEvent(address _from);

    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    function addCandidate(string memory _name) private returns (int) {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        return 1;
    }

    mapping(address => bool) public voters;

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount++;
        emit VotedEvent(msg.sender);
    }
}

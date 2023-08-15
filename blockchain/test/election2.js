var Election = artifacts.require("./Election.sol");

contract("Election", function(accounts) {
  var electionInstance;
  beforeEach(async () => {
    // electionInstance = await Election.new();
  });

  // TEST 1
  it("Add election",async () => {
    electionInstance = await Election.new();
    var elec = await electionInstance.addElectionEntity("Election1");
    assert.equal(elec.logs[0].args.name,"Election1","Event Not emitted");
    assert.equal((await electionInstance.elections(await electionInstance.electionCount())).name,"Election1","Election Not Created correctly");
    try{
      await electionInstance.addElectionEntity("Election2",{from: accounts[1]});
      assert(true,"Created election with a non-admin account");}
    catch(err) {}
  })
  it("Register a user",async () => {
    var id = await electionInstance.registerUser("TestUser",{from:accounts[2]});
    assert.equal(id.receipt.logs[0].args.uid,1,"Id is not added / emitted properly");
    try{var id = await electionInstance.registerUser("TestUser",{from:accounts[2]});assert(true,"Added multiple users with same address")}catch(err){}
    // assert.equal(id,1,"Not added properly");
    assert(!await electionInstance.verified(accounts[2]),"User verified without verifying");
    await electionInstance.registerUser("TestUser2",{from:accounts[3]});
  })
  it("Verify User",async () => {
    var res = await electionInstance.verifyUser(accounts[2],1,true,"Accepted");
    // console.log((await electionInstance.getUserVerificationRequests()).toString());
    assert.equal((await electionInstance.getUserVerificationRequests()).length,1,"Not filtered correctly : User Verification Requests");
    assert.equal((await electionInstance.getUserVerificationRequests())[0], 2,"Not filtered correctly : User Verification Requests (2)");
    assert(await electionInstance.verified(accounts[2]),"User not verified");
    var res = await electionInstance.verifyUser(accounts[3],2,false,"Rejected");
    assert(!await electionInstance.verified(accounts[3]),"User verified without verifying");
  })
  it("Send participation request",async () => {
    var res = await electionInstance.requestToParticipate(1,1,{from:accounts[2]})
    // console.log((await electionInstance.getUserParticipationRequests()).toString())
    assert.equal((await electionInstance.getUserParticipationRequests()).length,1,"Not filtered correctly : Participation Request User (1)")
    assert.equal((await electionInstance.getUserParticipationRequests())[0],1,"Not filterd corretly : Participation Request User (2)");
  })
  it("Accept participation request",async () => {
    await electionInstance.approveToVote(accounts[2],1,1)
  })
  it("Add candidate",async () => {
    await electionInstance.startAcceptingNominationRequests(1);
    await electionInstance.sendNominationRequest(1,1,"My Name");
    var c = await electionInstance.nominationRequestCountOfElection(1);
    assert.equal(c,1,"Request count is not equal");
    await electionInstance.sendNominationRequest(1,2,"My Name",{from:accounts[1]});
    assert.equal((await electionInstance.allNominationRequestOfElection(1,2))[0],2,"Request is not Corrext")
  })
  it("Accept candidate request",async () => {
    var e = await electionInstance.allNominationRequestOfElection(1,1);
    await electionInstance.approveNominationRequest(e.id);
    assert.equal((await electionInstance.numberOfCandidates(1)),1,"Candidate count not matched")
    assert.equal((await electionInstance.candidates(1,1)).name,"My Name","Not accepted correctly")
  })
  it("Votes",async()=> {
    var elec = await electionInstance.elections((await electionInstance.allowedElections(accounts[2],1)).id)
    assert.equal(elec.started,false,"Election not started properly")
    var can = await electionInstance.candidates(elec.id,1)
    assert.equal(can.id,1,"Not corrext");
    assert.equal(can.voteCount,0,"Vote Count not corrext");
    await electionInstance.startElection(elec.id);
    await electionInstance.vote(1,elec.id,can.id,can.candidateAddress,{from:accounts[2]})
    await electionInstance.endElection(elec.id);
    var can = await electionInstance.candidates(elec.id,1)
    try{await electionInstance.vote(1,elec.id,can.id,can.candidateAddress,{from:accounts[2]});assert(true,"Voted Multiple times");}catch(err) {if(isAssetError(err)) throw err;}
    assert.equal(can.voteCount,1,"Vote COunt not equal")
  })
  
});






function isAssetError(err) {
  return err.toString().includes("AssertionError");
}
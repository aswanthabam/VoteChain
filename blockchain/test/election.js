var Election = artifacts.require("./Election.sol");

contract("Election", function(accounts) {
  var electionInstance;
  beforeEach(async () => {
    electionInstance = await Election.new();
  });

  // TEST 1

  it("Create Election",async () => {
    var elec = await electionInstance.addElectionEntity("Election1");
    assert.equal(elec.logs[0].args.name,"Election1","Event Not emitted");
    assert.equal((await electionInstance.elections(await electionInstance.electionCount())).name,"Election1","Election Not Created correctly");
    try{
      await electionInstance.addElectionEntity("Election2",{from: accounts[1]});
      assert(true,"Created election with a non-admin account");}
    catch(err) {}
  });

  // TEST 2

  it("Add Candidate", async () => {
    // Add two election entity
    var elec = await electionInstance.addElectionEntity("Election1");
    var elec2 = await electionInstance.addElectionEntity("Election2");
    // Request to participate in an election
    var req = await electionInstance.requestToParticipate(elec.logs[0].args.electionId,12345678910,"Candidate1");
    assert.isNotNull(req.logs[0].args.requestId,"Request not completed"); // Check if event emitted successfully
    // Check if the request added successfully
    assert.equal((await electionInstance.allParticipationRequests(await electionInstance.requestCount())).name,"Candidate1","The Request is not added correctly");
    // Try to send participation requst for same election multiple times (Want to Fail)
    try{
      await electionInstance.requestToParticipate(elec.logs[0].args.electionId,12345678910,"Candidate1");
      assert(false,"Requested to participate in same eletion multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
    // Try to participate in multiple election (Want to success)
    try{
      req2 = await electionInstance.requestToParticipate(elec2.logs[0].args.electionId,12345678910,"Candidate1");
    }catch(err){
      assert(false,"Cant request to participate in multiple elections");
    }
    // Get all requestes by address
    reqCount = await electionInstance.numberOfParticipationRequests(accounts[0]);
    assert.equal(reqCount,2,"Not all requests are added by the user");
    assert.equal((await electionInstance.participationRequests(accounts[0],0)).electionId,1,"Not added correctly");
    assert.equal((await electionInstance.participationRequests(accounts[0],1)).electionId,2,"Not added correctly");
    // Request to participate in an election that doesnt exist (FAIL)
    try{
      await electionInstance.requestToParticipate(127,34343,"Candidate2");
      assert(false,"Request success to participate in a non existing election");
    }catch(err){if(isAssetError(err)) throw err;}
    // Try to approve a request 
    var can = await electionInstance.approveRequest(req.logs[0].args.requestId);
    assert.isNotNull(can.logs[0].args.candidateId,"The request was not approved correctly"); // Check if that succeed
    assert.equal(await electionInstance.numberOfCandidates(elec.logs[0].args.electionId),1,"The candidate was not added correctly");
    // Try to approve a request from a non admin account (FAIL)
    try{
      await electionInstance.approveRequest(req2.logs[0].args.requestId,{from:accounts[1]});
      assert(false,"Approved request with non admin account");
    }catch(err){if(isAssetError(err)) throw err;}
    // Try to send approval to a request multiple times
    try {
      await electionInstance.approveRequest(req.logs[0].args.requestId);
      assert(false,"Approved request multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
    // Check if a candidate is added successfully
    var canCount = await electionInstance.numberOfCandidates(1)
    var cann = await electionInstance.candidates(1,canCount);
    assert.equal(cann.name,"Candidate1","Not added correctly");
    assert.equal(cann.voteCount,0,"vote count is not zero");
    // Approving one more candidate and testing
    var req = await electionInstance.requestToParticipate(elec.logs[0].args.electionId,1234567891243421,"Candidate3",{from:accounts[1]});
    var can2 = await electionInstance.approveRequest(req.logs[0].args.requestId);
    assert.isNotNull(can2.logs[0].args.candidateId,"The request was not approved correctly"); // Check if that succeed
    assert.equal(await electionInstance.numberOfCandidates(elec.logs[0].args.electionId),2,"The candidate was not added correctly");
    var canCount = await electionInstance.numberOfCandidates(1)
    var cann = await electionInstance.candidates(1,canCount);
    assert.equal(cann.name,"Candidate3","Not added correctly");
    assert.equal(cann.voteCount,0,"vote count is not zero");
  });

  // TEST 3

  it("Registering a user",async ()=> {
    // electionInstance = await Election.deployed();
    await electionInstance.registerUser(123456789012,"TestUser1");
    assert.equal((await electionInstance.users(accounts[0])).name, "TestUser1","Name Not Matched");
    assert.equal((await electionInstance.users(accounts[0])).uid, 123456789012,"UID Not Matched");
    assert.equal((await electionInstance.users(accounts[0]))._address, accounts[0],"Address Not Matched");
  });

  // TEST 4

  it("User Duplication check", async () => {
    // electionInstance = await Election.deployed();
    await electionInstance.registerUser(123456789012,"TestUser1");
    try {
      // Call the method with wrong arguments, expecting it to throw an error
      await electionInstance.registerUser(123456789012,"TestUser2",{ from: accounts[3] });
      assert.fail("User with same UID Created");
    } catch (error) {
      // console.log(error)
      assert(error.message.includes("revert"), "Expected method to revert, but got different error: " + error.message);
    }
    try {
      // Call the method with wrong arguments, expecting it to throw an error
      await electionInstance.registerUser(123456789532,"TestUser2");
      assert.fail("User with same Address Created");
    } catch (error) {
      // console.log(error)
      assert(error.message.includes("revert"), "Expected method to revert, but got different error: " + error.message);
    }
  });

  // TEST 5

  it("Approve Voter",async () => {
    // Register a user
    var reg = await electionInstance.registerUser(123456789012,"TestUser1");
    assert.equal(reg.logs[0].args._address,accounts[0],"Not emmited event successfully");
    await electionInstance.registerUser(123456789013,"TestUser2",{from:accounts[1]});
    // Create an election instance
    var elec = await electionInstance.addElectionEntity("Election1");
    var elec = await electionInstance.addElectionEntity("Election2");
    // Verify a user to vote
    await electionInstance.verifyUser(accounts[0],123456789012);
    try{
      await electionInstance.verifyUser(accounts[0],123456789012,{from:accounts[1]});
      assert(false,"Verified to vote on a non admin account");
    }catch(err){if(isAssetError(err)) throw err;}
    try{
      await electionInstance.verifyUser(accounts[2],123456789012);
      assert(false,"Non existing account");
    }catch(err){if(isAssetError(err)) throw err;}
    try{
      await electionInstance.verifyUser(accounts[0],1234567);
      assert(false,"Non existing uid");
    }catch(err){if(isAssetError(err)) throw err;}
    try{
      await electionInstance.verifyUser(accounts[0],123456789012);
      assert(false,"Verified multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
    // Approve a user to vote on an election
    await electionInstance.approveToVote(accounts[0],123456789012,1);
    assert.equal(await electionInstance.allowedElectionsCount(accounts[0]),1,"Not allowed properly");
    assert.equal((await electionInstance.allowedElections(accounts[0],1)).id,1,"Not allowed properly(2)");
    // Approve a user to vote on an another election(MUL)
    await electionInstance.approveToVote(accounts[0],123456789012,2);
    assert.equal(await electionInstance.allowedElectionsCount(accounts[0]),2,"Not allowed properly(3)");
    assert.equal((await electionInstance.allowedElections(accounts[0],2)).id,2,"Not allowed properly(4)");
    // Approval of non verified account
    try{
      await electionInstance.approveToVote(accounts[1],123456789013,1);
      assert(false,"Approved non verified user");
    }catch(err){if(isAssetError(err)) throw err;}
    await electionInstance.verifyUser(accounts[1],123456789013);
    // Approval from non admin account
    try{
      await electionInstance.approveToVote(accounts[1],123456789013,1,{from:accounts[1]});
      assert(false,"Approved from non admin account");
    }catch(err){if(isAssetError(err)) throw err;}
    // Approved multiple times
    try{
      await electionInstance.approveToVote(accounts[0],123456789012,2);
      assert(false,"Approved multiple times");
    }catch(err){if(isAssetError(err)) throw err;}

  });
  it("Cast Vote",async ()=>{
    await electionInstance.registerUser(123456789012,"TestUser1");
    await electionInstance.registerUser(123456789013,"TestUser2",{from:accounts[1]});
    await electionInstance.verifyUser(accounts[0],123456789012);
    await electionInstance.verifyUser(accounts[1],123456789013);
    await electionInstance.addElectionEntity("Election1");
    await electionInstance.addElectionEntity("Election2");
    await electionInstance.approveToVote(accounts[0],123456789012,1);
    // await electionInstance.approveToVote(accounts[0],123456789012,2); // Not allowed
    await electionInstance.approveToVote(accounts[1],123456789013,1);
    await electionInstance.approveToVote(accounts[1],123456789013,2);
    await electionInstance.approveRequest((await electionInstance.requestToParticipate(1,12345678910,"Candidate1",{from:accounts[2]})).logs[0].args.requestId);
    await electionInstance.approveRequest((await electionInstance.requestToParticipate(1,12345678911,"Candidate2",{from:accounts[3]})).logs[0].args.requestId);
    await electionInstance.approveRequest((await electionInstance.requestToParticipate(2,12345678910,"Candidate1",{from:accounts[2]})).logs[0].args.requestId);
    await electionInstance.approveRequest((await electionInstance.requestToParticipate(2,12345678911,"Candidate2",{from:accounts[3]})).logs[0].args.requestId);
    // Now cast the vote

    // casting vote with invalid uid
    try{
      await electionInstance.vote(123456789013,1,1,accounts[2]);
      assert(false,"Voted with wrong sender uid");
    }catch(err){if(isAssetError(err)) throw err;}
    // casting vote to election which was not approved
    try{
      await electionInstance.vote(123456789012,2,1,accounts[2]);
      assert(false,"Voted on an election that is not allowed");
    }catch(err){if(isAssetError(err)) throw err;}
    await electionInstance.approveToVote(accounts[0],123456789012,2);
    // Non existing voter
    try{
      await electionInstance.vote(123456789012,2,4,accounts[2]);
      assert(false,"Voted to a non existing voter");
    }catch(err){if(isAssetError(err)) throw err;}
    try{
      await electionInstance.vote(123456789012,2,1,accounts[6]);
      assert(false,"Voted to a non existing voter(2)");
    }catch(err){if(isAssetError(err)) throw err;}
    // Caast a vote
    await electionInstance.vote(123456789012,1,1,accounts[2]);
    await electionInstance.vote(123456789013,1,1,accounts[2],{from:accounts[1]});
    await electionInstance.vote(123456789012,2,4,accounts[3]);
    await electionInstance.vote(123456789013,2,3,accounts[2],{from:accounts[1]});
    // console.log(await electionInstance.candidates(1,1))
    assert.equal((await electionInstance.candidates(1,1)).voteCount,2,"Votes didnt match to the assumtion");
    assert.equal((await electionInstance.candidates(1,2)).voteCount,0,"Votes didnt match to the assumtion(2)");
    assert.equal((await electionInstance.candidates(2,1)).voteCount,1,"Votes didnt match to the assumtion(3)");
    assert.equal((await electionInstance.candidates(2,2)).voteCount,1,"Votes didnt match to the assumtion(2)");
    // Multiple votes
    try{
      await electionInstance.vote(123456789012,1,1,accounts[2]);
      assert(false,"Tried to vote multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
    try{
      await electionInstance.vote(123456789012,1,2,accounts[3]);
      assert(false,"Tried to vote multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
  });
});






function isAssetError(err) {
  return err.toString().includes("AssertionError");
}
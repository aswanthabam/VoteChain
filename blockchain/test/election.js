var Election = artifacts.require("./Election.sol");

contract("Election", function(accounts) {
  var electionInstance;
  beforeEach(async () => {
    electionInstance = await Election.new();
  });
  
  it("Registering a user",async ()=> {
    // electionInstance = await Election.deployed();
    await electionInstance.registerUser(123456789012,"TestUser1");
    assert.equal((await electionInstance.users(accounts[0])).name, "TestUser1","Name Not Matched");
    assert.equal((await electionInstance.users(accounts[0])).uid, 123456789012,"UID Not Matched");
    assert.equal((await electionInstance.users(accounts[0]))._address, accounts[0],"Address Not Matched");
  });
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
  it("Create Election",async () => {
    var elec = await electionInstance.addElectionEntity("Election1");
    assert.equal(elec.logs[0].args.name,"Election1","Event Not emitted");
    assert.equal((await electionInstance.elections(elec.logs[0].args.electionId)).name,"Election1","Election Not Created correctly");
    try{
      await electionInstance.addElectionEntity("Election2",{from: accounts[1]});
      assert(true,"Created election with a non-admin account");}
    catch(err) {}
  });
  it("Add Candidate", async () => {
    var elec = await electionInstance.addElectionEntity("Election1");
    var elec2 = await electionInstance.addElectionEntity("Election2");
    var req = await electionInstance.requestToParticipate(elec.logs[0].args.electionId,12345678910,"Candidate1");
    assert.isNotNull(req.logs[0].args.requestId,"Request not completed");
    try{
      await electionInstance.requestToParticipate(elec.logs[0].args.electionId,12345678910,"Candidate1");
      assert(false,"Requested to participate in same eletion multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
    try{
      await electionInstance.requestToParticipate(elec2.logs[0].args.electionId,12345678910,"Candidate1");
    }catch(err){
      assert(false,"Cant request to participate in multiple elections");
    }
    try{
      await electionInstance.requestToParticipate(1,34343,"Candidate2");
      assert(true,"Request success to participate in a non existing election");
    }catch(err){if(isAssetError(err)) throw err;}
    var can = await electionInstance.approveRequest(req.logs[0].args.requestId);
    assert.isNotNull(can.logs[0].args.candidateId,"not approved");
    try{
      await electionInstance.approveRequest(req.logs[0].args.requestId,{from:accounts[0]});
      assert(false,"Approved request with non admin account");
    }catch(err){if(isAssetError(err)) throw err;}
    try {
      await electionInstance.approveRequest(req.logs[0].args.requestId);
      assert(false,"Approved request multiple times");
    }catch(err){if(isAssetError(err)) throw err;}
    

  });
  // it("Verification Check",async () => {
  //   await electionInstance.registerUser(123456789012,"TestUser1");
  //   assert.equal(await electionInstance.verified(accounts[0]),false,"User Verified without verifying");
  //   assert.equal(await electionInstance.approvedToVote(accounts[0]),false,"User Approved to vote without approving");
  // });
});

function isAssetError(err) {
  return err.toString().includes("AssertionError");
}
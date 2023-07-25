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
  it("ID Duplication check", async () => {
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

  });
  it("Verification Check",async () => {
    await electionInstance.registerUser(123456789012,"TestUser1");
    assert.equal(await electionInstance.verified(accounts[0]),false,"User Verified without verifying");
    assert.equal(await electionInstance.approvedToVote(accounts[0]),false,"User Approved to vote without approving");
  });
});
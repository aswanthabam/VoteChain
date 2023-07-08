const { providers } = require("web3");

App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    // if (typeof window.ethereum !== 'undefined') {
    //   // If a web3 instance is already provided by Meta Mask.
    //   App.web3Provider = window.ethereum;
    //   web3 = new Web3(window.ethereum);
    //   window.web3 = web3;
    //   window.ethereum.enable().then(() => {
    //     // Get the current account
    //     web3.eth.getAccounts().then((accounts) => {
    //       const currentAccount = accounts[0];
    //       console.log('Current Account:', currentAccount);
    //     });
    //   });
    // } else {
      // Specify default instance if no web3 instance provided
      App.web3Provider = new Web3.providers.HttpProvider('http://192.168.18.2:7545');
      web3 = new Web3(App.web3Provider);
    // }
    wallet = ethers.Wallet.createRandom();
    etherProvider = new ethers.providers.JsonRpcProvider('http://192.168.18.2:7545');
    App.importAccounts(wallet.privateKey);
    return App.initContract();
  },
  importAccounts:async function(privateKey,passphrase='mypass'){
    // const [,,,,account] = await etherProvider.listAccounts();
    // console.log(account);
    // await etherProvider.send('hardhat_impersonateAccount', [account]);
    // await etherProvider.send('hardhat_impersonateAccount',[wallet.address]);
    try{
      const responce = await axios.post('http://192.168.18.2:7545',{
        jsonrpc:'2.0',
        method:'personal_importRawKey',
        params:[privateKey,passphrase],
        id:1
      });
      if (responce.data.error) throw new Error(responce.data.error.message);
      console.log("Imported acount: "+responce.data.result);
      console.log(responce.data);

      const unlockResponce = await axios.post('http://192.168.18.2:7545',{
        jsonrpc:'2.0',
        method:'personal_unlockAccount',
        params:[responce.data.result,passphrase,null],
        id:2
      });

      if (unlockResponce.data.error) throw new Error(unlockResponce.data.error.message);
      console.log("Unlocked acount: ");
      console.log()
    }catch(err){
      console.log("error importing account");
      throw err;
    }
  },
  initContract: function() {
    $.getJSON("Election.json", function(election) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.Election = TruffleContract(election);
      // Connect provider to interact with contract
      App.contracts.Election.setProvider(App.web3Provider);

      return App.render();
    });
  },

  render: function() {
    var electionInstance;
    var loader = $("#loader");
    var content = $("#content");
  
    loader.show();
    content.hide();
    


    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = wallet.address; //account;
        $("#accountAddress").html("Your Account: " + App.account);
      }
    });
  
    // Load contract data
    App.contracts.Election.deployed().then(function(instance) {
      electionInstance = instance;
      return electionInstance.candidatesCount();
    }).then(function(candidatesCount) {
      var candidatesResults = $("#candidatesResults");
      candidatesResults.empty();
  
      var candidatesSelect = $('#candidatesSelect');
      candidatesSelect.empty();
  
      for (var i = 1; i <= candidatesCount; i++) {
        electionInstance.candidates(i).then(function(candidate) {
          var id = candidate[0];
          var name = candidate[1];
          var voteCount = candidate[2];
  
          // Render candidate Result
          var candidateTemplate = "<tr><th>" + id + "</th><td>" + name + "</td><td>" + voteCount + "</td></tr>"
          candidatesResults.append(candidateTemplate);
  
          // Render candidate ballot option
          var candidateOption = "<option value='" + id + "' >" + name + "</ option>"
          candidatesSelect.append(candidateOption);
        });
      }
      return electionInstance.voters(App.account);
    }).then(function(hasVoted) {
      // Do not allow a user to vote
      if(hasVoted) {
        $('form').hide();
      }
      loader.hide();
      content.show();
    }).catch(function(error) {
      console.warn(error);
    });
  },
  castVote: function() {
    var candidateId = $('#candidatesSelect').val();
    App.contracts.Election.deployed().then(function(instance) {
      return instance.vote(candidateId, { from: App.account });
    }).then(function(result) {
      // Wait for votes to update
      $("#content").hide();
      $("#loader").show();
    }).catch(function(err) {
      console.error(err);
    });
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
import './Init.css';
import Results from './components/Results/Results';
import VoteForm from './components/VoteForm/VoteForm';
import React,{Component} from 'react';
import { Web3 } from 'web3';
import axios from 'axios';
import election from './Election.json';
// import TruffleContract from 'truffle-contract';
class Init extends Component {
  state = {
    candidates:[],
    voted:false,
    loading:true
  }
  constructor(props) {
    super(props);
    window.state = this.state;
  }
  async set(val) {
    return new Promise(resolve=>{
      this.setState(val,()=>{resolve()});
    })
  }
  async componentDidMount() {
    await this.init();
  }
  async initWeb3() {
    console.log("Initializing Web3 client");
    const web3 = new Web3(new Web3.providers.HttpProvider('http://192.168.18.2:7545'));
    window.web3 = web3; // DEV
    await this.set({web3:web3});
    console.log("Web3 client initialized : ",web3);
    console.log(this.state);
  }
  async createWallet() {
    const web3 = this.state.web3;
    console.log("Creating a new wallet : ");
    // const wallet = ethers.Wallet.createRandom();
    // const etherProvider = new ethers.providers.JsonRpcProvider(App.env.ethereumServer);
    const wallet = web3.eth.accounts.create();
    await this.set({wallet:wallet,...this.state});
    console.log("Initialized wallet: "+wallet.address);
  }
  async exportAccount() {
    console.log("Importing account: ")
    var {address,privateKey} = this.state.wallet;

    var passphrase = 'mypass';
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
  }
  async requestEthers(duty = 'r') {
    var wallet = this.state.wallet;
    console.log("Requesting for ethers.. ")
    var res = await axios.post('http://192.168.18.2:3131/allocateEthersForRegistration',{address:wallet.address});

    if(res.data.error) console.log("Error occured : "+res.data.error.message);
    else {
      console.log("Account fueled!");
      console.log(res.data);
    }
  }
  async loadContracts() {
    var web3 = this.state.web3;
    console.log("Loading contracts ...");
    console.log(election);
    const Election = new web3.eth.Contract(election.abi,election.networks['5777'].address);
    window.Election = Election; // DEV
    console.log(Election);
    await new Promise(resolve => {this.setState(prevState => ({
      contracts: {
        ...prevState.contracts,
        Election: Election
      }
    }),async () => {
      resolve();
    });});
    console.log(this.state)
  }
  async loadCandidates() {
    var web3 = this.state.web3;
    var {Election} = this.state.contracts;
    console.log("Loading candidate details..");
    var candidatesCount = Number(await Election.methods.candidatesCount().call());
    var candidates = [];
    for(var i = 0;i < candidatesCount;i++){
      var candidate = await Election.methods.candidates(i+1).call()
      candidates.push({
        id:i+1,
        name:candidate.name,
        voteCount:Number(candidate.voteCount)
      });
    }
    console.log(candidates);
    await new Promise(resolve => {this.setState({candidates: candidates},()=>{resolve();})});
    console.log(this.state);
  }
  async voteCandidate(candidateId) {
    var {Election} = this.state.contracts;
    console.log("Voting ...");
    console.log('Candidate ',candidateId,this.state.candidates[candidateId-1]);
    var result = await Election.methods.vote(candidateId).send({from:this.state.wallet.address});
    console.log(result);
    await this.checkIsVoted();
    await this.loadCandidates();
  }
  async init() {
    await this.set({loading:true});
    await this.initWeb3(); // Initiate the new web3 client
    await this.createWallet(); // Create a new wallet
    await this.exportAccount(); // Export account to ganache
    await this.requestEthers(); // Request for initial ethers
    await this.loadContracts(); // Load the contracts
    await this.loadCandidates(); // Load all the candidates
    await this.checkIsVoted(); // check if already voted
    await this.set({loading:false});
  }

  async checkIsVoted() {
    console.log("Checking if voted?");
    var {Election} = this.state.contracts;
    var voted = await Election.methods.voters(this.state.wallet.address).call();
    await this.set({voted:voted});
    console.log("The voter is "+(voted?'voted':'not voted'));
  }
  render() {
    return (
      <div className="App">
        {this.state.loading ? <center>Loading ...</center> :<>
        {this.state.voted ? <center>You are already voted</center> : <VoteForm vote={this.voteCandidate.bind(this)} candidates={this.state.candidates}/>}
        <br/>
        <Results result={this.state.candidates}/>
        <br/>
        <center><span>Your account : {this.state.wallet && this.state.wallet.address}</span></center></>}
      </div>
    );
  }
}

export default Init;


import './Init.css';
import Results from './components/Results/Results';
import VoteForm from './components/VoteForm/VoteForm';
import {useEffect,useState} from 'react';
import { Web3 } from 'web3';
import { ethers } from "ethers";
import axios from 'axios';
import election from './Election.json';
import TruffleContract from 'truffle-contract';
function Init() {
  const [initRunning,setInitRunning] = useState(false);
  const init = async ()=>{
    if(initRunning)return;
    setInitRunning(true);
    console.log("Initializing Web3 client");
    const web3 = new Web3(new Web3.providers.HttpProvider('http://192.168.18.2:7545'));
    window.web3 = web3;
    console.log("Web3 client initialized : ",web3);
    console.log("Creating a new wallet : ");
    // const wallet = ethers.Wallet.createRandom();
    // const etherProvider = new ethers.providers.JsonRpcProvider(App.env.ethereumServer);
    const wallet = web3.eth.accounts.create();
    console.log("Initialized wallet: "+wallet.address);
    // Skipped impersonating the account

    console.log("Requesting for ethers.. ")
    var res = await axios.post('http://192.168.18.2:3131/allocateEthersForRegistration',{address:wallet.address});

    if(res.data.error) console.log("Error occured : "+res.data.error.message);
    else {
      console.log("Account fueled!");
      console.log(res.data);
    }
    console.log("Loading contracts ...");
    console.log(election);
    // const Election = new web3.eth.Contract(election);
    const Election = new TruffleContract(election);
    console.log(Election);

    setInitRunning(false);
  };
  return (
    <div className="App">
      <button onClick={init}>Start</button>
      <VoteForm/>
      <Results/>
    </div>
  );
}

export default Init;

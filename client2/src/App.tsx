import React, {useEffect, useState} from 'react';
import {Text, View,StyleSheet, Button} from 'react-native';
import Results from './components/Results/Results';
import "react-native-get-random-values"

// Import the the ethers shims (**BEFORE** ethers)
import "@ethersproject/shims"

import {ethers} from 'ethers';
import contractABI from './election.json';


const App = () => {
  const [state, setState] = useState("");
  const [candidates,setCandidates] = useState([]);
  const [stateProvider,setProvider] = useState(null);
  const [stateElection,setElection] = useState(null);
  const [stateWallet,setWallet] = useState(null);

  // variables
  var provider,election,wallet;

  useEffect(()=>{
    async function init () {
      await initWeb3();
      await loadCandidates();
      
    };
    init();
  },[]);

  const initWeb3 = async () => {
    console.log("Initializing Ethers.js ...");
    provider = new ethers.JsonRpcProvider("http://192.168.18.2:7545"); // JSONRpc provider
    await setProvider(provider); // Set the state
    console.log("Loading contracts");
    election = new ethers.Contract("0x494161E0b2015d7840E40F9DDae49De8a7B48A0A", contractABI, provider); // Load Election contract
    await setElection(prev => election); // Set the state
    console.log("Contract initialized ");
  };
  const loadCandidates = async () => {
    try {
      var candidatesCount = await election.candidatesCount(); // Load candidatesCount
      candidatesCount = parseInt(candidatesCount.toString()); // Parse from BigInt to Int
      var candidates = [];
      for(var i = 1;i <= candidatesCount;i++) {
        var can = await election.candidates(i); // Fetch Candidate
        var candidate = {
          key:i,
          name:can[1],
          votes:parseInt(can[2].toString())
        };
        candidates.push(candidate);
      }
      await setCandidates(candidates); // Set Candidates state
      console.log("The candiadates are ",candidates)
    }catch(err) {
      console.log(err);
    }
  }
  const createAccount = async () => {
    console.log("Creating a new account ..");
    try{wallet = ethers.Wallet.createRandom(provider);}catch(err){console.log("Error creating an account: ",err);}
    election = stateElection.connect(wallet);
    setElection(election);
    await setWallet(wallet);
    console.log("Account created : ");
    console.log(wallet.address);
  }
  const vote = async (candidateId) => {
    console.log("Voting to : ",candidates[candidateId-1].name);
    var res = await stateElection.vote(candidateId);
    console.log(res);
  }
  return (
    <View
      style={{
        flex: 1,
        alignItems: 'center',
      }}>
      <Button
        onPress={(()=>{createAccount()})}
        title="Create Account"
        color="#841584"
        accessibilityLabel="Learn more about this purple button"
      />
      <Button
        onPress={(async ()=>{vote(1)})}
        title="Vote Candidate 1"
        color="#841584"
        accessibilityLabel="Learn more about this purple button"
      />
      <Text style={{fontSize:25,fontWeight:900}}>Vote Chain</Text>
      <Results candidates={candidates}></Results>
      <Text>Your account is : {stateWallet == null ? "Creating ..." : stateWallet.address }</Text>
    </View>
  );
};
export default App;

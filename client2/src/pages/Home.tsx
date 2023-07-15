import React, {useEffect, useState} from 'react';
import {Text, View,StyleSheet, Button} from 'react-native';
import Results from '../components/Results/Results';
import "react-native-get-random-values"
// Import the the ethers shims (**BEFORE** ethers)
import "@ethersproject/shims"
import {Wallet, ethers} from 'ethers';
import 'react-native-crypto';

//import { Buffer } from 'buffer';
import contractABI from '../election.json';
import axios from "axios";
import VoteForm from '../components/VoteForm/VoteForm';
import AsyncStorage from '@react-native-async-storage/async-storage';

//import {RSA} from 'react-native-rsa-native';
// import { NativeModules } from 'react-native';

// // Access the native modules
// const { RandomNumberGenerator } = NativeModules;

export default function Home ({navigation, route}) {
  const [state, setState] = useState("");
  const [candidates,setCandidates] = useState([]);
  const [stateProvider,setProvider] = useState({});
  const [stateElection,setElection] = useState({});
  const [stateWallet,setWallet] = useState(null);

  // variables
  var provider,election,wallet;

  useEffect(()=>{
    async function init () {
      const [provider,election] = await initWeb3();
      await loadCandidates(election);
      await loadAccount();
    };
    init();
  },[]);

  const initWeb3 = async () => {
    console.log("Initializing Ethers.js ...");
    var url = await AsyncStorage.getItem("blockchainUrl") || "http://192.168.18.2:7545";
    console.log("The url is : ",url);
    provider = new ethers.JsonRpcProvider(url); // JSONRpc provider
    await setProvider(provider); // Set the state
    console.log("Loading contracts");
    election = new ethers.Contract("0x6ea72486a146e2b3cD3D1d5908B3107eB72F4991", contractABI, provider); // Load Election contract
    await setElection(prev => election); // Set the state
    console.log("Contract initialized ");
    return [provider,election];
  };
  const loadCandidates = async (election = stateElection) => {
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
  const loadAccount = async (provider = stateProvider) => {
    console.log("FInding if saved account exists");
    var privateKey = await AsyncStorage.getItem("privateKey");
    if(privateKey != null && privateKey != undefined) {
      console.log("Private key exists");
      wallet = new Wallet(privateKey,provider);
      console.log("Created wallet: ",wallet.address);
      setWallet(wallet);
      return true;
    }else {
      console.log("Account doesnt exists")
      return false;
    }
  }
  const createAccount = async (provider = stateProvider) => {
    var start = performance.now();
    console.log("Creating a new account ..");
    try{wallet = ethers.Wallet.createRandom(provider);}catch(err){console.log("Error creating an account: ",err);}
    var end = performance.now();
    console.log("New account generated in : ",end-start,"ms");
    // setElection(election);
    await setWallet(wallet);
    await AsyncStorage.setItem("privateKey",wallet.privateKey);
    // start = performance.now();
    // var enWallet = await wallet.encrypt("mypassword",{},(progress)=>{console.log(progress)});
    // console.log("Encrypted: ",enWallet);
    // console.log("Encrypted in ",performance.now() - start,"ms");
    console.log("Account created : ");
    console.log(wallet.address);
  }
  const requestEthers = async (wallet = stateWallet) => {
    var res = await axios.post((await AsyncStorage.getItem("helperServerUrl") || "http://192.168.18.2:3131")+'/allocateEthersForRegistration',{address:wallet.address});
    if(res.data.error) console.log("Error occured : "+res.data.error.message);
    else {
      console.log("Account fueled!");
      console.log(res.data);
    }
  }
  const vote = async (candidateId,provider = stateProvider,election = stateElection, wallet = stateWallet) => {
    console.log("Voting to : ",candidates[candidateId-1].name);
    console.log("Account balance: ",await provider.getBalance(wallet.address))
    try{
      // stateWallet.provider = stateProvider;
      var election2 = await election.connect(stateWallet);
      console.log(election2.runner);
      var res = await election2.vote(candidateId);
      console.log(res);
    }catch(err) {
      console.log("Error : ",err);
    }
    await loadCandidates();
  }
  
  return (
    <View
      style={{
        flex: 1,
        alignItems: 'center',
      }}>
      
      {/*
      <Button
        onPress={(async ()=>{vote(1)})}
        title="Vote Candidate 1"
        color="#841584"
        accessibilityLabel="Learn more about this purple button"
      /> */}
      <VoteForm candidates={candidates} vote={vote}></VoteForm>
      <Text style={{fontSize:25,fontWeight:900}}>Vote Chain</Text>
      <Results candidates={candidates}></Results>
      <Text>Your account is : {stateWallet == null ? "Creating ..." : stateWallet.address }</Text>
      <Button
        onPress={(async ()=>{new Promise(async resolve=>{await createAccount();resolve();})})}
        title="Create Account"
        color="#841584"
        accessibilityLabel=""
      />
      <Button
        onPress={(async ()=>{requestEthers()})}
        title="Request Ethers"
        color="#841584"
        accessibilityLabel="Learn more about this purple button"
      />
      <Button
        onPress={(async ()=>{navigation.navigate("Admin")})}
        title="Go to admin"
        color="#ccc"
      />
    </View>
  );
};
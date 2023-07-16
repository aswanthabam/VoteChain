import React, {useEffect, useState} from 'react';
import {Text, View,StyleSheet, Button} from 'react-native';
import Results from '../components/Results/Results';
import { getRandomValues } from 'react-native-quick-crypto';
global.getRandomValues = getRandomValues;

// Import the the ethers shims (**BEFORE** ethers)
import "@ethersproject/shims"
import {Wallet, ethers} from '../ethers';
// import 'react-native-crypto';

//import { Buffer } from 'buffer';
import contractABI from '../election.json';
import axios from "axios";
import VoteForm from '../components/VoteForm/VoteForm';
import AsyncStorage from '@react-native-async-storage/async-storage';

//import {RSA} from 'react-native-rsa-native';
// import { NativeModules } from 'react-native';

// // Access the native modules
// const { RandomNumberGenerator } = NativeModules;

export default class Home extends React.Component {
  state = {
    candidates:[],
    provider:{},
    election:{},
    wallet:null,
    test:"Test Result"
  }
  // variables
  // var provider,election,wallet;
  constructor(val: any) {
    super(val);
    this.set = this.set.bind(this);
    this.vote = this.vote.bind(this);
  }
  async componentDidMount(){
    await this.init();
  }
  async init () {
    const [provider,election] = await this.initWeb3();
    await this.loadCandidates(election);
    await this.loadAccount(provider);
  };
  set(val : any) {
    return new Promise<Boolean>((resolve => {this.setState(val,()=>{resolve(true);})}))
  }
  async initWeb3() {
    console.log("Initializing Ethers.js ...");
    var url = await AsyncStorage.getItem("blockchainUrl") || "http://192.168.18.2:7545";
    console.log("The url is : ",url);
    var provider = new ethers.JsonRpcProvider(url); // JSONRpc provider
    await this.set({provider:provider}); // Set the state
    console.log("Loading contracts");
    var election = new ethers.Contract(await AsyncStorage.getItem("contractAddress") || "0x6ea72486a146e2b3cD3D1d5908B3107eB72F4991", contractABI, provider); // Load Election contract
    await this.set({election:election}); // Set the state
    console.log("Contract initialized ");
    return [provider,election];
  };
  async loadCandidates(election = this.state.election) {
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
      await this.set({candidates:candidates}); // Set Candidates state
      console.log("The candiadates are ",candidates)
    }catch(err) {
      console.log(err);
    }
  }
  async loadAccount(provider = this.state.provider){
    console.log("FInding if saved account exists");
    var privateKey = await AsyncStorage.getItem("privateKey");
    if(privateKey != null && privateKey != undefined) {
      console.log("Private key exists");
      var wallet = new Wallet(privateKey,provider);
      console.log("Created wallet: ",wallet.address);
      await this.set({wallet:wallet});
      return true;
    }else {
      console.log("Account doesnt exists")
      return false;
    }
  }
  createAccount (provider = this.state.provider) {
    return new Promise<Boolean>(async (resolve) => {
      var start = performance.now();
      console.log("Creating a new account ..");
      var wallet = null;
      try{wallet = ethers.Wallet.createRandom(provider);}catch(err){console.log("Error creating an account: ",err);}
      var end = performance.now();
      console.log("New account generated in : ",(end-start)/1000,"s");
      // setElection(election);
      await this.set({wallet:wallet});
      await AsyncStorage.setItem("privateKey",wallet.privateKey);
      // start = performance.now();
      // var enWallet = await wallet.encrypt("mypassword",{},(progress)=>{console.log(progress)});
      // console.log("Encrypted: ",enWallet);
      // console.log("Encrypted in ",performance.now() - start,"ms");
      console.log("Account created : ");
      console.log(wallet.address);
      resolve(true);
    });
  }
  async requestEthers(wallet = this.state.wallet) {
    var res = await axios.post((await AsyncStorage.getItem("helperServerUrl") || "http://192.168.18.2:3131")+'/allocateEthersForRegistration',{address:wallet.address});
    if(res.data.error) console.log("Error occured : "+res.data.error.message);
    else {
      console.log("Account fueled!");
      console.log(res.data);
    }
  }
  async vote (candidateId : number,provider = this.state.provider,election = this.state.election, wallet = this.state.wallet) {
    console.log("Voting to : ",this.state.candidates[candidateId-1].name);
    console.log("Account balance: ",parseInt((await provider.getBalance(wallet.address)).toString()) / 1000000000000000000," ETH")
    try{
      // stateWallet.provider = stateProvider;
      var election2 = await election.connect(wallet);
      console.log(election2.runner);
      var res = await election2.vote(candidateId);
      console.log(res);
    }catch(err) {
      console.log("Error : ",err);
    }
    await this.loadCandidates();
  }
  
  async test(wallet = this.state.wallet) {
    console.log(wallet.privateKey);
    this.set({test:wallet.privateKey});
  }
  render() {
    return (
      <View
        style={{
          flex: 1,
          alignItems: 'center',
        }}>
        
        <VoteForm candidates={this.state.candidates} vote={this.vote}></VoteForm>
        <Text style={{fontSize:25,fontWeight:900}}>Vote Chain</Text>
        <Results candidates={this.state.candidates}></Results>
        <Text selectable>Your account is : {this.state.wallet == null ? "Creating ..." : this.state.wallet.address }</Text>
        <Button
          onPress={()=>{this.createAccount().then(val=>{console.log(val)})}}
          title="Create Account"
          color="#841584"
          accessibilityLabel=""
        />
        <Button
          onPress={(async ()=>{this.requestEthers()})}
          title="Request Ethers"
          color="#841584"
          accessibilityLabel="Learn more about this purple button"
        />
        <Button
          onPress={(async ()=>{this.props.navigation.navigate("Admin")})}
          title="Go to admin"
          color="#ccc"
        />
        <Button
          onPress={(async ()=>{this.test()})}
          title="Run Test Commands"
          color="#ccc"
        />
        <Text selectable>Test Results : {this.state.test}</Text>
      </View>
    );  
  }
};
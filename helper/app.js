const Web3 = require("web3.js");
const express = require("express");

const app = express();

app.use((req,res,next) => {
  const App = {
    init:{
      App.web3Provider = new Web3.providers.HttpProvider('http://192.168.18.5:7545');
      const web3 = new Web3(App.web3Provider);
    }
  }
  
});
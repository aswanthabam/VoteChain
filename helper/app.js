const env = process.env;

const web3 = require("web3");
const express = require("express");
const app = express();
var cors = require('cors');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const Tx = require('ethereumjs-tx').Transaction;
var mongoose = require("mongoose");

const senderAddress= env.BLOCKCHAIN_SENDER_ADDRESS || "0x23b0438547a478A4a32501961137Dd0E1E8C36FE";
const senderPrivateKey= env.BLOCKCHAIN_SENDER_PRIVATE_KEY || "0x411dfacefaff8672907b8c0163485422cdc9d63b80f5414825ecc2dadab7f11e";

const publicRouter = require("./routes/api/public.js");

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(function(req, res, next) {
  res.header('Access-Control-Allow-Credentials', true);
  res.header('Access-Control-Allow-Origin', req.headers.origin);
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,UPDATE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept');
  next();
});
app.use((req,res,next) => {
  web3Provider = new web3.Web3.providers.HttpProvider(env.BLOCKCHAIN_URL || 'http://192.168.18.2:7545');
  req.web3 = new web3.Web3(web3Provider);
  req.senderAccount = {
    privateKey: Buffer.from(senderPrivateKey, 'hex'),
    address: senderAddress
  };
  next();
});

app.use("/api/public/", publicRouter);
app.post('/allocateEthersForRegistration',async (req,res) => {
  var {address} = req.body;
  var {web3} = req;
  var out = {};
  if(address == null) res.json({status:400,description:"Account not provided"});
  else {
    
    console.log(`Attempting to make transaction from ${senderAddress} to ${address}`);
    const nonce = await web3.eth.getTransactionCount(senderAddress);

    // Prepare the transaction object
    const txObject = {
      nonce: nonce,
      from:senderAddress,
      to: address,
      value: web3.utils.toWei("0.1", "ether"),
      // gasLimit: web3.utils.toHex(21000),
      // gasPrice: await web3.eth.getGasPrice(),
      maxFeePerGas: web3.utils.toHex(999999999999),
      maxPriorityFeePerGas: web3.utils.toHex(2500)
    };
    txObject.gas = await web3.eth.estimateGas(txObject);
    console.log(txObject);

    // Create a new transaction instance
    // const tx = new Tx(txObject);
    // console.log(req.senderAccount.privateKey)
    // Sign the transaction
    // tx.sign(req.senderAccount.privateKey);

    // Serialize the transaction
    // const serializedTx = tx.serialize();

    // Send the signed transaction to the network
    // const createReceipt = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'));
    // console.log(await web3.eth.accounts.signTransaction(txObject,senderPrivateKey));
    await web3.eth.accounts.wallet.add(senderPrivateKey);
    const createReceipt = await web3.eth.sendTransaction(txObject);
    // console.log(createReceipt)
    res.json({ status: 200,receipt: createReceipt.transactionHash });

  }
});
const uri = "mongodb+srv://avctech:avctech@cluster0.4wxlu7g.mongodb.net/votechain?retryWrites=true&w=majority"; 
 mongoose.connect(uri,{ useNewUrlParser: true, useUnifiedTopology: true}) 
   .then((result) =>{ 
     console.log("CONNECTED TO DB"); 
   }) 
   .catch((err) => { 
     console.log("CANT CONNECT TO DB"); 
     console.log(err); 
 }); 
 
app.listen(env.PORT || 3131,()=>{
  console.log("Server started !");
})
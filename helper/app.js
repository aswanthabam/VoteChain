const env = process.env;

const web3 = require("web3");
const express = require("express");
const app = express();
var cors = require('cors');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const Tx = require('ethereumjs-tx').Transaction;

const senderAddress="0xb75292331020A552C4e34b9C74cFBdD121DB105b";
const senderPrivateKey="0x2414e477ab252f795ef27c6ed53f44c292bac38adb25e41c1022d2f4bf594c0f";

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
  web3Provider = new web3.Web3.providers.HttpProvider('http://192.168.18.2:7545');
  req.web3 = new web3.Web3(web3Provider);
  req.senderAccount = {
    privateKey: Buffer.from(senderPrivateKey, 'hex'),
    address: senderAddress
  };
  next();
});

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
      // gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
    };

    // Create a new transaction instance
    // const tx = new Tx(txObject);
    // console.log(req.senderAccount.privateKey)
    // Sign the transaction
    // tx.sign(req.senderAccount.privateKey);

    // Serialize the transaction
    // const serializedTx = tx.serialize();

    // Send the signed transaction to the network
    // const createReceipt = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'));
    const createReceipt = await web3.eth.sendTransaction(txObject);
    // console.log(createReceipt)
    res.json({ status: 200, receipt: createReceipt.transactionHash });

  }
});

app.listen(env.PORT || 3131,()=>{
  console.log("Server started !");
})
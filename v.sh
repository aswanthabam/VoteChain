#!/bin/bash

openTerminal() {
  gnome-terminal --tab 
}
printSecondMenu() {
echo -n "
  1) Change Environment
choose: "
}
readSecondValue() {
  read val;
  case $val in 
    1)
      echo "Enter BlockChain Url: ($BLOCKCHAIN_URL)"
      read bu
      [[ ! -z "$bu" ]] && export BLOCKCHAIN_URL=$bu && echo "export BLOCKCHAIN_URL=$bu" >> ~/.bashrc
      echo "Sender Address: ($BLOCKCHAIN_SENDER_ADDRESS)"
      read sa
      [[ ! -z "$sa" ]] && export BLOCKCHAIN_SENDER_ADDRESS=$sa && echo "export BLOCKCHAIN_SENDER_ADDRESS=$sa" >> ~/.bashrc
      echo "Private Key: ($BLOCKCHAIN_SENDER_PRIVATE_KEY)"
      read pk
      [[ ! -z "$pk" ]] && export BLOCKCHAIN_SENDER_PRIVATE_KEY=$pk && echo "export BLOCKCHAIN_SENDER_PRIVATE_KEY=$pk" >> ~/.bashrc
      echo "Open new terminal for take in effect !"
    ;;
  esac
}
moreOptions() {
printSecondMenu
readSecondValue
}
printMenu() {
  echo -n "
What do you want to do ?
  1) Start client
  2) Start Helper Server
  3) Open Truffle Console
  4) Compile Contracts
  5) Migrate Contracts (with update client)
  6) Production build
  7) Start Ganache Cli 
  
  9) More Options
  10) Start Dev
  11) Git push
Choose : "
}
readValue() {
[[ -z "$1" ]] && read opt || opt="$1"

if [ "$opt" -eq 1 ]
then
  cd client && npm start
elif [ "$opt" -eq 2 ]
then 
  cd helper && nodemon
elif [ "$opt" -eq 3 ]
then
  cd blockchain && truffle console
elif [ "$opt" -eq 4 ]
then
  cd blockchain && truffle compile
elif [ "$opt" -eq 5 ]
then 
  cd blockchain && truffle migrate --reset && cp build/contracts/Election.json ../client/src/Election.json
elif [ "$opt" -eq 10 ]
then echo hi
elif [ "$opt" -eq 11 ]
then
  echo -n "Enter commit message : "
  read comm
  git add . && git commit -m "$comm" && git push origin main
elif [ "$opt" -eq 9 ]
then
  moreOptions
elif [ "$opt" -eq 7 ]
then
  echo "Starting ganache..."
  ganache -g 0 -d -e 300 --database.dbPath=ganache.db -l 0xa460f -p 7545
else 
  echo "Invalid option"
fi
}
main() {
  [[ -z "$1" ]] && printMenu
  readValue
}
main "$1"
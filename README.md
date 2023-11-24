# VoteChain

This repo contains the code for the client side mobile app of VoteChain (Blockchain based E-Voting System). The app is made using flutter and implement the connection with blockchain using web3dart library.

### Setup

- Clone the repo
- run `flutter pub get`
- setup virtual machine using android studio
- run app:

  - in debug mode:

  ```bash
  flutter run
  ```

  - build apk:

  ```bash
  flutter build apk --split-abis
  ```

> Note that this project is under development and **doesnt accept any contributions** until an initial implementation of the project is done.

## Project Structure

This project is splitted into multiple repos for ease of maintainance. some of them are private due to security concerns.

- [VoteChain Admin Panel](https://github.com/aswanthabam/votechain-admin) : Admin Panel for managing the platform
- [VoteChain Blockchain Network](https://github.com/aswanthabam/votechain-chain) : Blockchain network code
- [Votechain Face verification Module](https://github.com/aswanthabam/face-verification) : Face verification module for votechain
- [VoteChain Candidate Nomination Panel](https://github.com/aswanthabam/votechain-candidate) : Not Started

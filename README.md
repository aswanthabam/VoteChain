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
  flutter build apk --split-per-abi
  ```

> Note that this project is under development and **doesnt accept any contributions** until an initial implementation of the project is done.

## Folder structure

The main folder `lib` contains these subfolders and follow this folder structure.

| Folder  | Description                                                                                                                                                             |
| ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| screens | All the UI components are enclosed within this folder, this folder contains two sub folders pages (for all the display pages) and widgets ( for all the global widgets) |
| service | all the services, to connect with the backend, like blockchain api etc.                                                                                                 |
| contracts    | All auto generated contract accessing code by web3 builder |
| provider | Flutter state management provider codes |
| utils | utility functions and classes |


## Project Structure

This project is splitted into multiple repos for ease of maintainance. some of them are private due to security concerns.

- [VoteChain Admin Panel](https://github.com/aswanthabam/votechain-admin) 
- [VoteChain Blockchain Network](https://github.com/aswanthabam/votechain-chain)
- [Votechain Face verification Module](https://github.com/aswanthabam/face-verification)
- [VoteChain Candidate Nomination Panel](https://github.com/aswanthabam/votechain-candidate) 

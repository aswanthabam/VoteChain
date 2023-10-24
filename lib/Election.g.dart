// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"candidateId","type":"uint256"}],"name":"ApprovedNominationRequest","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"candidateId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"CandidateAddedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"ElectionCreatedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"ElectionEndedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"ElectionRemovedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"ElectionStartedAcceptingCandidateRequestsEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"ElectionStartedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"requestId","type":"uint256"}],"name":"NominationRequestEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"electioId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"requestId","type":"uint256"}],"name":"UserElectionParticipationRequestedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"_address","type":"address"},{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"}],"name":"UserRegisteredEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"election","type":"uint256"},{"indexed":false,"internalType":"string","name":"message","type":"string"}],"name":"UserReviewedParticipationRequestEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"},{"indexed":false,"internalType":"bool","name":"status","type":"bool"},{"indexed":false,"internalType":"string","name":"reason","type":"string"}],"name":"UserVerifiedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"}],"name":"VotedEvent","type":"event"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"allNominationRequests","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"from","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"bool","name":"approved","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"allowedElections","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bool","name":"started","type":"bool"},{"internalType":"bool","name":"ended","type":"bool"},{"internalType":"bool","name":"accept_request","type":"bool"},{"internalType":"bool","name":"removed_election","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"allowedElectionsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"candidates","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"candidateAddress","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"voteCount","type":"uint256"},{"internalType":"uint256","name":"uid","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"candidatesCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"electionCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"elections","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bool","name":"started","type":"bool"},{"internalType":"bool","name":"ended","type":"bool"},{"internalType":"bool","name":"accept_request","type":"bool"},{"internalType":"bool","name":"removed_election","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"nominationRequestCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"nominationRequests","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"from","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"bool","name":"approved","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"numberOfCandidates","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"numberOfNominationRequests","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"userParticipationRequests","outputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"bool","name":"accepted","type":"bool"},{"internalType":"bool","name":"rejected","type":"bool"},{"internalType":"string","name":"text","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"userVerificationRequests","outputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"address","name":"_address","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bool","name":"verified","type":"bool"},{"internalType":"bool","name":"rejected","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"users","outputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"address","name":"_address","type":"address"},{"internalType":"string","name":"name","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"verified","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getUserParticipationRequests","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getUserVerificationRequests","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"string","name":"_name","type":"string"}],"name":"registerUser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"bool","name":"status","type":"bool"},{"internalType":"string","name":"status_text","type":"string"}],"name":"verifyUser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"requestToParticipate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"approveToVote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"startElection","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"endElection","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"removeElection","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"startAcceptingNominationRequests","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"string","name":"name","type":"string"}],"name":"addElectionEntity","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"string","name":"name","type":"string"}],"name":"sendNominationRequest","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"approveNominationRequest","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"uint256","name":"candidateId","type":"uint256"},{"internalType":"address","name":"candidateAddress","type":"address"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]',
  'Election',
);

class Election extends _i1.GeneratedContract {
  Election({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<AllNominationRequests> allNominationRequests(
    BigInt $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'bb6c1c19'));
    final params = [$param0];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return AllNominationRequests(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<AllowedElections> allowedElections(
    _i1.EthereumAddress $param1,
    BigInt $param2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'd7ce122e'));
    final params = [
      $param1,
      $param2,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return AllowedElections(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> allowedElectionsCount(
    _i1.EthereumAddress $param3, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '55065289'));
    final params = [$param3];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Candidates> candidates(
    BigInt $param4,
    BigInt $param5, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '7de14242'));
    final params = [
      $param4,
      $param5,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Candidates(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> candidatesCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '2d35a8a2'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> electionCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '997d2830'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Elections> elections(
    BigInt $param6, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '5e6fef01'));
    final params = [$param6];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Elections(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> nominationRequestCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '0023986c'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<NominationRequests> nominationRequests(
    _i1.EthereumAddress $param7,
    BigInt $param8, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '18f9dcf5'));
    final params = [
      $param7,
      $param8,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return NominationRequests(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> numberOfCandidates(
    BigInt $param9, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '5e1e339b'));
    final params = [$param9];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> numberOfNominationRequests(
    _i1.EthereumAddress $param10, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '1d1a2884'));
    final params = [$param10];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<UserParticipationRequests> userParticipationRequests(
    BigInt $param11, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '0754f41d'));
    final params = [$param11];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return UserParticipationRequests(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<UserVerificationRequests> userVerificationRequests(
    BigInt $param12, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, 'b4347a46'));
    final params = [$param12];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return UserVerificationRequests(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Users> users(
    _i1.EthereumAddress $param13, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, 'a87430ba'));
    final params = [$param13];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Users(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> verified(
    _i1.EthereumAddress $param14, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '0db065f4'));
    final params = [$param14];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> getUserParticipationRequests(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '1e365fb1'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> getUserVerificationRequests(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'e7746b03'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerUser(
    String _name, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, '704f1b94'));
    final params = [_name];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> verifyUser(
    _i1.EthereumAddress user,
    BigInt uid,
    bool status,
    String status_text, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, '6becabb5'));
    final params = [
      user,
      uid,
      status,
      status_text,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> requestToParticipate(
    BigInt uid,
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, 'bc91f043'));
    final params = [
      uid,
      electionId,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> approveToVote(
    _i1.EthereumAddress user,
    BigInt uid,
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, 'fdb5f3fb'));
    final params = [
      user,
      uid,
      electionId,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> startElection(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, '6d32dc4b'));
    final params = [electionId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> endElection(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[23];
    assert(checkSignature(function, '9c98bcbb'));
    final params = [electionId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> removeElection(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[24];
    assert(checkSignature(function, 'c830b8cc'));
    final params = [electionId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> startAcceptingNominationRequests(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[25];
    assert(checkSignature(function, 'd7809e70'));
    final params = [electionId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addElectionEntity(
    String name, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[26];
    assert(checkSignature(function, '9e218875'));
    final params = [name];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> sendNominationRequest(
    BigInt electionId,
    BigInt uid,
    String name, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[27];
    assert(checkSignature(function, '28f97e73'));
    final params = [
      electionId,
      uid,
      name,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> approveNominationRequest(
    BigInt id, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[28];
    assert(checkSignature(function, '6ae9d7da'));
    final params = [id];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> vote(
    BigInt uid,
    BigInt electionId,
    BigInt candidateId,
    _i1.EthereumAddress candidateAddress, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[29];
    assert(checkSignature(function, '8a917c87'));
    final params = [
      uid,
      electionId,
      candidateId,
      candidateAddress,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all ApprovedNominationRequest events emitted by this contract.
  Stream<ApprovedNominationRequest> approvedNominationRequestEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ApprovedNominationRequest');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return ApprovedNominationRequest(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all CandidateAddedEvent events emitted by this contract.
  Stream<CandidateAddedEvent> candidateAddedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('CandidateAddedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return CandidateAddedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionCreatedEvent events emitted by this contract.
  Stream<ElectionCreatedEvent> electionCreatedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionCreatedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return ElectionCreatedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionEndedEvent events emitted by this contract.
  Stream<ElectionEndedEvent> electionEndedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionEndedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return ElectionEndedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionRemovedEvent events emitted by this contract.
  Stream<ElectionRemovedEvent> electionRemovedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionRemovedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return ElectionRemovedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionStartedAcceptingCandidateRequestsEvent events emitted by this contract.
  Stream<ElectionStartedAcceptingCandidateRequestsEvent>
      electionStartedAcceptingCandidateRequestsEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionStartedAcceptingCandidateRequestsEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return ElectionStartedAcceptingCandidateRequestsEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionStartedEvent events emitted by this contract.
  Stream<ElectionStartedEvent> electionStartedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionStartedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return ElectionStartedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all NominationRequestEvent events emitted by this contract.
  Stream<NominationRequestEvent> nominationRequestEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('NominationRequestEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return NominationRequestEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all UserElectionParticipationRequestedEvent events emitted by this contract.
  Stream<UserElectionParticipationRequestedEvent>
      userElectionParticipationRequestedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('UserElectionParticipationRequestedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return UserElectionParticipationRequestedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all UserRegisteredEvent events emitted by this contract.
  Stream<UserRegisteredEvent> userRegisteredEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('UserRegisteredEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return UserRegisteredEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all UserReviewedParticipationRequestEvent events emitted by this contract.
  Stream<UserReviewedParticipationRequestEvent>
      userReviewedParticipationRequestEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('UserReviewedParticipationRequestEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return UserReviewedParticipationRequestEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all UserVerifiedEvent events emitted by this contract.
  Stream<UserVerifiedEvent> userVerifiedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('UserVerifiedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return UserVerifiedEvent(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all VotedEvent events emitted by this contract.
  Stream<VotedEvent> votedEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('VotedEvent');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast(),
        result.data!,
      );
      return VotedEvent(
        decoded,
        result,
      );
    });
  }
}

class AllNominationRequests {
  AllNominationRequests(List<dynamic> response)
      : id = (response[0] as BigInt),
        from = (response[1] as _i1.EthereumAddress),
        name = (response[2] as String),
        uid = (response[3] as BigInt),
        electionId = (response[4] as BigInt),
        approved = (response[5] as bool);

  final BigInt id;

  final _i1.EthereumAddress from;

  final String name;

  final BigInt uid;

  final BigInt electionId;

  final bool approved;
}

class AllowedElections {
  AllowedElections(List<dynamic> response)
      : id = (response[0] as BigInt),
        name = (response[1] as String),
        started = (response[2] as bool),
        ended = (response[3] as bool),
        acceptrequest = (response[4] as bool),
        removedelection = (response[5] as bool);

  final BigInt id;

  final String name;

  final bool started;

  final bool ended;

  final bool acceptrequest;

  final bool removedelection;
}

class Candidates {
  Candidates(List<dynamic> response)
      : id = (response[0] as BigInt),
        candidateAddress = (response[1] as _i1.EthereumAddress),
        name = (response[2] as String),
        voteCount = (response[3] as BigInt),
        uid = (response[4] as BigInt);

  final BigInt id;

  final _i1.EthereumAddress candidateAddress;

  final String name;

  final BigInt voteCount;

  final BigInt uid;
}

class Elections {
  Elections(List<dynamic> response)
      : id = (response[0] as BigInt),
        name = (response[1] as String),
        started = (response[2] as bool),
        ended = (response[3] as bool),
        acceptrequest = (response[4] as bool),
        removedelection = (response[5] as bool);

  final BigInt id;

  final String name;

  final bool started;

  final bool ended;

  final bool acceptrequest;

  final bool removedelection;
}

class NominationRequests {
  NominationRequests(List<dynamic> response)
      : id = (response[0] as BigInt),
        from = (response[1] as _i1.EthereumAddress),
        name = (response[2] as String),
        uid = (response[3] as BigInt),
        electionId = (response[4] as BigInt),
        approved = (response[5] as bool);

  final BigInt id;

  final _i1.EthereumAddress from;

  final String name;

  final BigInt uid;

  final BigInt electionId;

  final bool approved;
}

class UserParticipationRequests {
  UserParticipationRequests(List<dynamic> response)
      : uid = (response[0] as BigInt),
        electionId = (response[1] as BigInt),
        accepted = (response[2] as bool),
        rejected = (response[3] as bool),
        text = (response[4] as String);

  final BigInt uid;

  final BigInt electionId;

  final bool accepted;

  final bool rejected;

  final String text;
}

class UserVerificationRequests {
  UserVerificationRequests(List<dynamic> response)
      : uid = (response[0] as BigInt),
        address = (response[1] as _i1.EthereumAddress),
        name = (response[2] as String),
        verified = (response[3] as bool),
        rejected = (response[4] as bool);

  final BigInt uid;

  final _i1.EthereumAddress address;

  final String name;

  final bool verified;

  final bool rejected;
}

class Users {
  Users(List<dynamic> response)
      : uid = (response[0] as BigInt),
        address = (response[1] as _i1.EthereumAddress),
        name = (response[2] as String);

  final BigInt uid;

  final _i1.EthereumAddress address;

  final String name;
}

class ApprovedNominationRequest {
  ApprovedNominationRequest(
    List<dynamic> response,
    this.event,
  ) : candidateId = (response[0] as BigInt);

  final BigInt candidateId;

  final _i1.FilterEvent event;
}

class CandidateAddedEvent {
  CandidateAddedEvent(
    List<dynamic> response,
    this.event,
  )   : candidateId = (response[0] as BigInt),
        name = (response[1] as String);

  final BigInt candidateId;

  final String name;

  final _i1.FilterEvent event;
}

class ElectionCreatedEvent {
  ElectionCreatedEvent(
    List<dynamic> response,
    this.event,
  )   : electionId = (response[0] as BigInt),
        name = (response[1] as String);

  final BigInt electionId;

  final String name;

  final _i1.FilterEvent event;
}

class ElectionEndedEvent {
  ElectionEndedEvent(
    List<dynamic> response,
    this.event,
  )   : electionId = (response[0] as BigInt),
        name = (response[1] as String);

  final BigInt electionId;

  final String name;

  final _i1.FilterEvent event;
}

class ElectionRemovedEvent {
  ElectionRemovedEvent(
    List<dynamic> response,
    this.event,
  )   : uid = (response[0] as BigInt),
        name = (response[1] as String);

  final BigInt uid;

  final String name;

  final _i1.FilterEvent event;
}

class ElectionStartedAcceptingCandidateRequestsEvent {
  ElectionStartedAcceptingCandidateRequestsEvent(
    List<dynamic> response,
    this.event,
  )   : uid = (response[0] as BigInt),
        name = (response[1] as String);

  final BigInt uid;

  final String name;

  final _i1.FilterEvent event;
}

class ElectionStartedEvent {
  ElectionStartedEvent(
    List<dynamic> response,
    this.event,
  )   : electionId = (response[0] as BigInt),
        name = (response[1] as String);

  final BigInt electionId;

  final String name;

  final _i1.FilterEvent event;
}

class NominationRequestEvent {
  NominationRequestEvent(
    List<dynamic> response,
    this.event,
  ) : requestId = (response[0] as BigInt);

  final BigInt requestId;

  final _i1.FilterEvent event;
}

class UserElectionParticipationRequestedEvent {
  UserElectionParticipationRequestedEvent(
    List<dynamic> response,
    this.event,
  )   : uid = (response[0] as BigInt),
        electioId = (response[1] as BigInt),
        requestId = (response[2] as BigInt);

  final BigInt uid;

  final BigInt electioId;

  final BigInt requestId;

  final _i1.FilterEvent event;
}

class UserRegisteredEvent {
  UserRegisteredEvent(
    List<dynamic> response,
    this.event,
  )   : address = (response[0] as _i1.EthereumAddress),
        uid = (response[1] as BigInt);

  final _i1.EthereumAddress address;

  final BigInt uid;

  final _i1.FilterEvent event;
}

class UserReviewedParticipationRequestEvent {
  UserReviewedParticipationRequestEvent(
    List<dynamic> response,
    this.event,
  )   : uid = (response[0] as BigInt),
        election = (response[1] as BigInt),
        message = (response[2] as String);

  final BigInt uid;

  final BigInt election;

  final String message;

  final _i1.FilterEvent event;
}

class UserVerifiedEvent {
  UserVerifiedEvent(
    List<dynamic> response,
    this.event,
  )   : uid = (response[0] as BigInt),
        status = (response[1] as bool),
        reason = (response[2] as String);

  final BigInt uid;

  final bool status;

  final String reason;

  final _i1.FilterEvent event;
}

class VotedEvent {
  VotedEvent(
    List<dynamic> response,
    this.event,
  )   : to = (response[0] as _i1.EthereumAddress),
        uid = (response[1] as BigInt);

  final _i1.EthereumAddress to;

  final BigInt uid;

  final _i1.FilterEvent event;
}

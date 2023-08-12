// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"candidateId","type":"uint256"}],"name":"ApprovedParticipationRequest","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"candidateId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"CandidateAddedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"}],"name":"ElectionCreatedEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"requestId","type":"uint256"}],"name":"ParticipationRequestEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"_address","type":"address"}],"name":"UserRegisteredEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"uid","type":"uint256"}],"name":"VotedEvent","type":"event"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"allParticipationRequests","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"from","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"bool","name":"approved","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"allowedElections","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bool","name":"started","type":"bool"},{"internalType":"bool","name":"ended","type":"bool"},{"internalType":"bool","name":"accept_request","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"allowedElectionsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"candidates","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"candidateAddress","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"voteCount","type":"uint256"},{"internalType":"uint256","name":"uid","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"candidatesCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"electionCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"elections","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bool","name":"started","type":"bool"},{"internalType":"bool","name":"ended","type":"bool"},{"internalType":"bool","name":"accept_request","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"numberOfCandidates","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"numberOfParticipationRequests","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"participationRequests","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"from","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"bool","name":"approved","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"requestCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"users","outputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"address","name":"_address","type":"address"},{"internalType":"string","name":"name","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"verified","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"string","name":"_name","type":"string"}],"name":"registerUser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"uid","type":"uint256"}],"name":"verifyUser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"approveToVote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"string","name":"name","type":"string"}],"name":"addElectionEntity","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"string","name":"name","type":"string"}],"name":"requestToParticipate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"approveRequest","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"uid","type":"uint256"},{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"uint256","name":"candidateId","type":"uint256"},{"internalType":"address","name":"candidateAddress","type":"address"}],"name":"vote","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]',
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
  Future<AllParticipationRequests> allParticipationRequests(
    BigInt $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '29d2270c'));
    final params = [$param0];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return AllParticipationRequests(response);
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
  Future<BigInt> numberOfCandidates(
    BigInt $param7, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '5e1e339b'));
    final params = [$param7];
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
  Future<BigInt> numberOfParticipationRequests(
    _i1.EthereumAddress $param8, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'f8b776b5'));
    final params = [$param8];
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
  Future<ParticipationRequests> participationRequests(
    _i1.EthereumAddress $param9,
    BigInt $param10, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, 'e4c99adc'));
    final params = [
      $param9,
      $param10,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return ParticipationRequests(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> requestCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '5badbe4c'));
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
  Future<Users> users(
    _i1.EthereumAddress $param11, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'a87430ba'));
    final params = [$param11];
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
    _i1.EthereumAddress $param12, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '0db065f4'));
    final params = [$param12];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerUser(
    BigInt uid,
    String _name, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '1c57333e'));
    final params = [
      uid,
      _name,
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
  Future<String> verifyUser(
    _i1.EthereumAddress user,
    BigInt uid, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '32d345da'));
    final params = [
      user,
      uid,
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
    final function = self.abi.functions[16];
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
  Future<String> addElectionEntity(
    String name, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
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
  Future<String> requestToParticipate(
    BigInt electionId,
    BigInt uid,
    String name, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'cb751090'));
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
  Future<String> approveRequest(
    BigInt id, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, 'd7d1bbdb'));
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
    final function = self.abi.functions[20];
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

  /// Returns a live stream of all ApprovedParticipationRequest events emitted by this contract.
  Stream<ApprovedParticipationRequest> approvedParticipationRequestEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ApprovedParticipationRequest');
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
      return ApprovedParticipationRequest(
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

  /// Returns a live stream of all ParticipationRequestEvent events emitted by this contract.
  Stream<ParticipationRequestEvent> participationRequestEventEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ParticipationRequestEvent');
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
      return ParticipationRequestEvent(
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

class AllParticipationRequests {
  AllParticipationRequests(List<dynamic> response)
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
        acceptrequest = (response[4] as bool);

  final BigInt id;

  final String name;

  final bool started;

  final bool ended;

  final bool acceptrequest;
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
        acceptrequest = (response[4] as bool);

  final BigInt id;

  final String name;

  final bool started;

  final bool ended;

  final bool acceptrequest;
}

class ParticipationRequests {
  ParticipationRequests(List<dynamic> response)
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

class Users {
  Users(List<dynamic> response)
      : uid = (response[0] as BigInt),
        address = (response[1] as _i1.EthereumAddress),
        name = (response[2] as String);

  final BigInt uid;

  final _i1.EthereumAddress address;

  final String name;
}

class ApprovedParticipationRequest {
  ApprovedParticipationRequest(
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

class ParticipationRequestEvent {
  ParticipationRequestEvent(
    List<dynamic> response,
    this.event,
  ) : requestId = (response[0] as BigInt);

  final BigInt requestId;

  final _i1.FilterEvent event;
}

class UserRegisteredEvent {
  UserRegisteredEvent(
    List<dynamic> response,
    this.event,
  ) : address = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress address;

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

// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"permissionsAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"ElectionCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"ElectionEnded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"ElectionStarted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"},{"indexed":true,"internalType":"address","name":"voterAddress","type":"address"}],"name":"VoteCasted","type":"event"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"address","name":"","type":"address"}],"name":"candidateVoteCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"elections","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"enum VoteChain.ElectionStatus","name":"status","type":"uint8"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"eligibleCanidates","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"eligibleElections","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"address","name":"","type":"address"}],"name":"voterVoted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getEligibleElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"enum VoteChain.ElectionStatus","name":"status","type":"uint8"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"address payable","name":"candidateAddress","type":"address"}],"name":"vote","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_name","type":"string"},{"internalType":"string","name":"_description","type":"string"},{"internalType":"uint256","name":"_startDate","type":"uint256"},{"internalType":"uint256","name":"_endDate","type":"uint256"}],"name":"createElection","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"startElection","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"endElection","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"address payable","name":"voter","type":"address"}],"name":"addEligibleVoter","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"address payable[]","name":"_candidates","type":"address[]"}],"name":"addEligibleCandidates","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'VoteChain',
);

class VoteChain extends _i1.GeneratedContract {
  VoteChain({
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
  Future<BigInt> candidateVoteCount(
    BigInt $param0,
    _i1.EthereumAddress $param1, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '029eaaec'));
    final params = [
      $param0,
      $param1,
    ];
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
    BigInt $param2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '5e6fef01'));
    final params = [$param2];
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
  Future<_i1.EthereumAddress> eligibleCanidates(
    BigInt $param3, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '544ecc35'));
    final params = [$param3];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> eligibleElections(
    _i1.EthereumAddress $param4,
    BigInt $param5, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '15caf0b7'));
    final params = [
      $param4,
      $param5,
    ];
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
  Future<bool> voterVoted(
    BigInt $param6,
    _i1.EthereumAddress $param7, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '868abff2'));
    final params = [
      $param6,
      $param7,
    ];
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
  Future<List<dynamic>> getEligibleElections({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '49bfd05b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> vote(
    BigInt electionId,
    _i1.EthereumAddress candidateAddress, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '02d947ef'));
    final params = [
      electionId,
      candidateAddress,
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
  Future<String> createElection(
    String _name,
    String _description,
    BigInt _startDate,
    BigInt _endDate, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '7ad36e84'));
    final params = [
      _name,
      _description,
      _startDate,
      _endDate,
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
    final function = self.abi.functions[9];
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
    final function = self.abi.functions[10];
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
  Future<String> addEligibleVoter(
    BigInt electionId,
    _i1.EthereumAddress voter, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'beca56e5'));
    final params = [
      electionId,
      voter,
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
  Future<String> addEligibleCandidates(
    BigInt electionId,
    List<_i1.EthereumAddress> _candidates, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'bff8b178'));
    final params = [
      electionId,
      _candidates,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all ElectionCreated events emitted by this contract.
  Stream<ElectionCreated> electionCreatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionCreated');
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
      return ElectionCreated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionEnded events emitted by this contract.
  Stream<ElectionEnded> electionEndedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionEnded');
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
      return ElectionEnded(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ElectionStarted events emitted by this contract.
  Stream<ElectionStarted> electionStartedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ElectionStarted');
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
      return ElectionStarted(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all VoteCasted events emitted by this contract.
  Stream<VoteCasted> voteCastedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('VoteCasted');
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
      return VoteCasted(
        decoded,
        result,
      );
    });
  }
}

class Elections {
  Elections(List<dynamic> response)
      : id = (response[0] as BigInt),
        name = (response[1] as String),
        description = (response[2] as String),
        startDate = (response[3] as BigInt),
        endDate = (response[4] as BigInt),
        status = (response[5] as BigInt);

  final BigInt id;

  final String name;

  final String description;

  final BigInt startDate;

  final BigInt endDate;

  final BigInt status;
}

class ElectionCreated {
  ElectionCreated(
    List<dynamic> response,
    this.event,
  ) : electionId = (response[0] as BigInt);

  final BigInt electionId;

  final _i1.FilterEvent event;
}

class ElectionEnded {
  ElectionEnded(
    List<dynamic> response,
    this.event,
  ) : electionId = (response[0] as BigInt);

  final BigInt electionId;

  final _i1.FilterEvent event;
}

class ElectionStarted {
  ElectionStarted(
    List<dynamic> response,
    this.event,
  ) : electionId = (response[0] as BigInt);

  final BigInt electionId;

  final _i1.FilterEvent event;
}

class VoteCasted {
  VoteCasted(
    List<dynamic> response,
    this.event,
  )   : electionId = (response[0] as BigInt),
        voterAddress = (response[1] as _i1.EthereumAddress);

  final BigInt electionId;

  final _i1.EthereumAddress voterAddress;

  final _i1.FilterEvent event;
}

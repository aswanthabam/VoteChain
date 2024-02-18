// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"permissionsAddress","type":"address"},{"internalType":"address","name":"linkerAddress","type":"address"},{"internalType":"address","name":"candidateAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"ElectionCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"ElectionEnded","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"ElectionStarted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"electionId","type":"uint256"},{"indexed":true,"internalType":"address","name":"voterAddress","type":"address"}],"name":"VoteCasted","type":"event"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"address","name":"","type":"address"}],"name":"candidateVoteCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"","type":"string"}],"name":"constituencyElectionCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"","type":"string"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"constituency_election_linker","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"electionCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"elections","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"str1","type":"string"},{"internalType":"string","name":"str2","type":"string"}],"name":"isEqual","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"pure","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"address","name":"","type":"address"}],"name":"voterVoted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"address","name":"candidateAddress","type":"address"}],"name":"vote","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_name","type":"string"},{"internalType":"string","name":"_description","type":"string"},{"internalType":"uint256","name":"_startDate","type":"uint256"},{"internalType":"uint256","name":"_endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"_nominationStatus","type":"uint8"}],"name":"createElection","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getAllElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"constituency","type":"string"}],"name":"getAllElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getUpComingElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"constituency","type":"string"}],"name":"getUpComingElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"constituency","type":"string"}],"name":"getOnGoingElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getOnGoingElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"constituency","type":"string"}],"name":"getNominatableElections","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"startDate","type":"uint256"},{"internalType":"uint256","name":"endDate","type":"uint256"},{"internalType":"string","name":"constituency","type":"string"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"nominationStatus","type":"uint8"},{"internalType":"bool","name":"resultsPublished","type":"bool"}],"internalType":"struct VoteChain.ElectionInfo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"enum VoteChain.ElectionNominationStatus","name":"status","type":"uint8"}],"name":"setElectionNominationStatus","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"publishResults","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"getResults","outputs":[{"components":[{"internalType":"address","name":"candidateAddress","type":"address"},{"internalType":"uint256","name":"voteCount","type":"uint256"}],"internalType":"struct VoteChain.Result[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"getTotalVoteCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getMyNominations","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getMyElections","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function","constant":true}]',
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
  Future<BigInt> constituencyElectionCount(
    String $param2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '5e95c8f9'));
    final params = [$param2];
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
  Future<BigInt> constituency_election_linker(
    String $param3,
    BigInt $param4, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'da32e62c'));
    final params = [
      $param3,
      $param4,
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
  Future<BigInt> electionCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
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
    BigInt $param5, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '5e6fef01'));
    final params = [$param5];
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
  Future<bool> isEqual(
    String str1,
    String str2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '465c4105'));
    final params = [
      str1,
      str2,
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
  Future<bool> voterVoted(
    BigInt $param8,
    _i1.EthereumAddress $param9, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '868abff2'));
    final params = [
      $param8,
      $param9,
    ];
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
  Future<String> vote(
    BigInt electionId,
    _i1.EthereumAddress candidateAddress, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[8];
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
    BigInt _endDate,
    String constituency,
    BigInt _nominationStatus, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'e94c50f0'));
    final params = [
      _name,
      _description,
      _startDate,
      _endDate,
      constituency,
      _nominationStatus,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getAllElections({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '7fd5f268'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getAllElections$2(
    String constituency, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'fbbf9492'));
    final params = [constituency];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getUpComingElections({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '5f8e03aa'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getUpComingElections$2(
    String constituency, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, 'a14811e9'));
    final params = [constituency];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getOnGoingElections(
    String constituency, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '635fe9de'));
    final params = [constituency];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getOnGoingElections$2({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, 'e8a472b3'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getNominatableElections(
    String constituency, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '7a534ced'));
    final params = [constituency];
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
  Future<String> setElectionNominationStatus(
    BigInt electionId,
    BigInt status, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'b83d1be8'));
    final params = [
      electionId,
      status,
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
  Future<String> publishResults(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'bfad9cc0'));
    final params = [electionId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getResults(
    BigInt electionId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, '81a60c0d'));
    final params = [electionId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getTotalVoteCount(
    BigInt electionId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, 'b05847bd'));
    final params = [electionId];
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
  Future<List<BigInt>> getMyNominations({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, '42b1fb15'));
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
  Future<List<BigInt>> getMyElections({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, '01786e7f'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<BigInt>();
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
        constituency = (response[5] as String),
        nominationStatus = (response[6] as BigInt),
        resultsPublished = (response[7] as bool);

  final BigInt id;

  final String name;

  final String description;

  final BigInt startDate;

  final BigInt endDate;

  final String constituency;

  final BigInt nominationStatus;

  final bool resultsPublished;
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

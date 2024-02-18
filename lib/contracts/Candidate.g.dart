// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"permissionsAddress","type":"address"},{"internalType":"address","name":"linkerAddress","type":"address"},{"internalType":"address","name":"voterAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"candidateAddress","type":"address"}],"name":"CandidateRegistered","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"candidateAddress","type":"address"}],"name":"CandidateVerified","type":"event"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"candidateCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"candidates","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"nominations","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"nominationsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"registerCandidate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"},{"internalType":"address","name":"_candidateAddress","type":"address"}],"name":"verifyNomination","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"getNominations","outputs":[{"components":[{"internalType":"address","name":"voter_address","type":"address"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"},{"internalType":"string","name":"constituency","type":"string"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"internalType":"struct Voter.VoterAccount[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"getCandidates","outputs":[{"components":[{"internalType":"address","name":"voter_address","type":"address"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"},{"internalType":"string","name":"constituency","type":"string"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"internalType":"struct Voter.VoterAccount[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"electionId","type":"uint256"}],"name":"withdrawNomination","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'Candidate',
);

class Candidate extends _i1.GeneratedContract {
  Candidate({
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
  Future<BigInt> candidateCount(
    BigInt $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'b1ff97c1'));
    final params = [$param0];
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
  Future<_i1.EthereumAddress> candidates(
    BigInt $param1,
    BigInt $param2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '7de14242'));
    final params = [
      $param1,
      $param2,
    ];
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
  Future<_i1.EthereumAddress> nominations(
    BigInt $param3,
    BigInt $param4, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'cac5dfd8'));
    final params = [
      $param3,
      $param4,
    ];
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
  Future<BigInt> nominationsCount(
    BigInt $param5, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'a6aad28b'));
    final params = [$param5];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerCandidate(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '0b2a85ea'));
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
  Future<String> verifyNomination(
    BigInt electionId,
    _i1.EthereumAddress _candidateAddress, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '4814dc71'));
    final params = [
      electionId,
      _candidateAddress,
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
  Future<List<dynamic>> getNominations(
    BigInt electionId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'c86b73f3'));
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
  Future<List<dynamic>> getCandidates(
    BigInt electionId, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '3e39a7a5'));
    final params = [electionId];
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
  Future<String> withdrawNomination(
    BigInt electionId, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '91a1e9ef'));
    final params = [electionId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all CandidateRegistered events emitted by this contract.
  Stream<CandidateRegistered> candidateRegisteredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('CandidateRegistered');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast().cast(),
        result.data!,
      );
      return CandidateRegistered(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all CandidateVerified events emitted by this contract.
  Stream<CandidateVerified> candidateVerifiedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('CandidateVerified');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!.cast().cast(),
        result.data!,
      );
      return CandidateVerified(
        decoded,
        result,
      );
    });
  }
}

class CandidateRegistered {
  CandidateRegistered(
    List<dynamic> response,
    this.event,
  ) : candidateAddress = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress candidateAddress;

  final _i1.FilterEvent event;
}

class CandidateVerified {
  CandidateVerified(
    List<dynamic> response,
    this.event,
  ) : candidateAddress = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress candidateAddress;

  final _i1.FilterEvent event;
}

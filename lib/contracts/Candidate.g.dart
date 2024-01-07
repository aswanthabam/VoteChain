// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"permissionsAddress","type":"address"},{"internalType":"address","name":"linkerAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"candidateAddress","type":"address"}],"name":"CandidateRegistered","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"candidateAddress","type":"address"}],"name":"CandidateVerified","type":"event"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"candidates","outputs":[{"internalType":"address payable","name":"walletAddress","type":"address"},{"internalType":"enum Candidate.CandidateStatus","name":"status","type":"uint8"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"constituency","type":"string"}],"name":"registerCandidate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_candidateAddress","type":"address"},{"internalType":"enum Candidate.CandidateStatus","name":"status","type":"uint8"}],"name":"verifyNomination","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
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
  Future<Candidates> candidates(
    _i1.EthereumAddress $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '8ab66a90'));
    final params = [$param0];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Candidates(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerCandidate(
    String constituency, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '9eb88db6'));
    final params = [constituency];
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
    _i1.EthereumAddress _candidateAddress,
    BigInt status, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'a97b10ad'));
    final params = [
      _candidateAddress,
      status,
    ];
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
        result.topics!.cast(),
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
        result.topics!.cast(),
        result.data!,
      );
      return CandidateVerified(
        decoded,
        result,
      );
    });
  }
}

class Candidates {
  Candidates(List<dynamic> response)
      : walletAddress = (response[0] as _i1.EthereumAddress),
        status = (response[1] as BigInt);

  final _i1.EthereumAddress walletAddress;

  final BigInt status;
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

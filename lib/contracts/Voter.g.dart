// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"permissionsAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"voterAddress","type":"address"}],"name":"VoterRegistered","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"voterAddress","type":"address"}],"name":"VoterVerified","type":"event"},{"inputs":[{"internalType":"string","name":"","type":"string"}],"name":"email_linker","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"","type":"string"}],"name":"phone_linker","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"registered_voter_count","outputs":[{"internalType":"uint232","name":"","type":"uint232"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"registration_list","outputs":[{"internalType":"uint232","name":"voter_id","type":"uint232"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"},{"internalType":"address payable","name":"voter_address","type":"address"},{"internalType":"enum Voter.VoterStatus","name":"status","type":"uint8"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"voter_count","outputs":[{"internalType":"uint232","name":"","type":"uint232"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"voter_id_linker","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"voters","outputs":[{"internalType":"address payable","name":"voter_address","type":"address"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"details","type":"tuple"}],"name":"registerVoter","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"voterID","type":"uint256"},{"internalType":"enum Voter.VoterStatus","name":"_status","type":"uint8"}],"name":"updateVoterStatus","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'Voter',
);

class Voter extends _i1.GeneratedContract {
  Voter({
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
  Future<_i1.EthereumAddress> email_linker(
    String $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'c26398ab'));
    final params = [$param0];
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
  Future<_i1.EthereumAddress> phone_linker(
    String $param1, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'db256a83'));
    final params = [$param1];
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
  Future<BigInt> registered_voter_count({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '525581c7'));
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
  Future<Registration_list> registration_list(
    BigInt $param2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'ce60f9a1'));
    final params = [$param2];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Registration_list(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> voter_count({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'beb604e0'));
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
  Future<BigInt> voter_id_linker(
    _i1.EthereumAddress $param3, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'c26f84fa'));
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
  Future<Voters> voters(
    _i1.EthereumAddress $param4, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'a3ec138d'));
    final params = [$param4];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Voters(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> registerVoter(
    dynamic details, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, 'f73bb8bd'));
    final params = [details];
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
  Future<String> updateVoterStatus(
    BigInt voterID,
    BigInt _status, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'd3c14b62'));
    final params = [
      voterID,
      _status,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all VoterRegistered events emitted by this contract.
  Stream<VoterRegistered> voterRegisteredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('VoterRegistered');
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
      return VoterRegistered(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all VoterVerified events emitted by this contract.
  Stream<VoterVerified> voterVerifiedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('VoterVerified');
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
      return VoterVerified(
        decoded,
        result,
      );
    });
  }
}

class Registration_list {
  Registration_list(List<dynamic> response)
      : voterid = (response[0] as BigInt),
        voterinfo = (response[1] as dynamic),
        voteraddress = (response[2] as _i1.EthereumAddress),
        status = (response[3] as BigInt);

  final BigInt voterid;

  final dynamic voterinfo;

  final _i1.EthereumAddress voteraddress;

  final BigInt status;
}

class Voters {
  Voters(List<dynamic> response)
      : voteraddress = (response[0] as _i1.EthereumAddress),
        voterinfo = (response[1] as dynamic);

  final _i1.EthereumAddress voteraddress;

  final dynamic voterinfo;
}

class VoterRegistered {
  VoterRegistered(
    List<dynamic> response,
    this.event,
  ) : voterAddress = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress voterAddress;

  final _i1.FilterEvent event;
}

class VoterVerified {
  VoterVerified(
    List<dynamic> response,
    this.event,
  ) : voterAddress = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress voterAddress;

  final _i1.FilterEvent event;
}

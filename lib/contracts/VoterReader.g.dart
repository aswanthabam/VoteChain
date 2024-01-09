// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"voterAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"uint104","name":"startIndex","type":"uint104"},{"internalType":"uint104","name":"count","type":"uint104"}],"name":"getAllVoters","outputs":[{"components":[{"internalType":"address","name":"voter_address","type":"address"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"},{"internalType":"string","name":"constituency","type":"string"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"internalType":"struct Voter.VoterAccount[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getVoterInfo","outputs":[{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"},{"internalType":"string","name":"constituency","type":"string"}],"internalType":"struct Voter.VoterInfo","name":"","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getRegistrationStatus","outputs":[{"internalType":"enum Voter.VoterStatus","name":"","type":"uint8"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint104","name":"count","type":"uint104"}],"name":"getUnverifiedVoters","outputs":[{"components":[{"internalType":"uint232","name":"voter_id","type":"uint232"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"},{"internalType":"string","name":"constituency","type":"string"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"},{"internalType":"address","name":"voter_address","type":"address"},{"internalType":"enum Voter.VoterStatus","name":"status","type":"uint8"}],"internalType":"struct Voter.VoterRegistration[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"uint104","name":"startIndex","type":"uint104"},{"internalType":"uint104","name":"count","type":"uint104"}],"name":"getUnverifiedVoters","outputs":[{"components":[{"internalType":"uint232","name":"voter_id","type":"uint232"},{"components":[{"internalType":"string","name":"aadhar_number","type":"string"},{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"},{"internalType":"string","name":"constituency","type":"string"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"},{"internalType":"address","name":"voter_address","type":"address"},{"internalType":"enum Voter.VoterStatus","name":"status","type":"uint8"}],"internalType":"struct Voter.VoterRegistration[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function","constant":true}]',
  'VoterReader',
);

class VoterReader extends _i1.GeneratedContract {
  VoterReader({
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
  Future<List<dynamic>> getAllVoters(
    BigInt startIndex,
    BigInt count, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '8f9b3d1b'));
    final params = [
      startIndex,
      count,
    ];
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
  Future<dynamic> getVoterInfo({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '5e132bbd'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getRegistrationStatus({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'e35fb241'));
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
  Future<List<dynamic>> getUnverifiedVoters(
    BigInt count, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '547a843f'));
    final params = [count];
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
  Future<List<dynamic>> getUnverifiedVoters$2(
    BigInt startIndex,
    BigInt count, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'f2128d9d'));
    final params = [
      startIndex,
      count,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }
}

// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"voterAddress","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"father_linker","outputs":[{"internalType":"address payable","name":"voter_address","type":"address"},{"components":[{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"guardian_linker","outputs":[{"internalType":"address payable","name":"voter_address","type":"address"},{"components":[{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"mother_linker","outputs":[{"internalType":"address payable","name":"voter_address","type":"address"},{"components":[{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"spouse_linker","outputs":[{"internalType":"address payable","name":"voter_address","type":"address"},{"components":[{"components":[{"internalType":"string","name":"first_name","type":"string"},{"internalType":"string","name":"middle_name","type":"string"},{"internalType":"string","name":"last_name","type":"string"},{"internalType":"string","name":"dob","type":"string"}],"internalType":"struct Voter.VoterPersonalInfo","name":"personal_info","type":"tuple"},{"components":[{"internalType":"string","name":"phone","type":"string"},{"internalType":"string","name":"email","type":"string"}],"internalType":"struct Voter.VoterContactInfo","name":"contact_info","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"permeant_address","type":"tuple"},{"components":[{"internalType":"string","name":"state","type":"string"},{"internalType":"string","name":"district","type":"string"},{"internalType":"string","name":"locality","type":"string"},{"internalType":"string","name":"ward","type":"string"},{"internalType":"string","name":"house_name","type":"string"},{"internalType":"string","name":"house_number","type":"string"},{"internalType":"string","name":"street","type":"string"},{"internalType":"string","name":"pincode","type":"string"}],"internalType":"struct Voter.VoterAddressInfo","name":"current_address","type":"tuple"},{"internalType":"bool","name":"married","type":"bool"},{"internalType":"bool","name":"orphan","type":"bool"}],"internalType":"struct Voter.VoterInfo","name":"voter_info","type":"tuple"}],"stateMutability":"view","type":"function"}]',
  'Linker',
);

class Linker extends _i1.GeneratedContract {
  Linker({
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
  Future<Father_linker> father_linker(
    _i1.EthereumAddress $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'b95abc68'));
    final params = [$param0];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Father_linker(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Guardian_linker> guardian_linker(
    _i1.EthereumAddress $param1, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '93c83d55'));
    final params = [$param1];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Guardian_linker(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Mother_linker> mother_linker(
    _i1.EthereumAddress $param2, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '4163b6d9'));
    final params = [$param2];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Mother_linker(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Spouse_linker> spouse_linker(
    _i1.EthereumAddress $param3, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '9e77415d'));
    final params = [$param3];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Spouse_linker(response);
  }
}

class Father_linker {
  Father_linker(List<dynamic> response)
      : voteraddress = (response[0] as _i1.EthereumAddress),
        voterinfo = (response[1] as dynamic);

  final _i1.EthereumAddress voteraddress;

  final dynamic voterinfo;
}

class Guardian_linker {
  Guardian_linker(List<dynamic> response)
      : voteraddress = (response[0] as _i1.EthereumAddress),
        voterinfo = (response[1] as dynamic);

  final _i1.EthereumAddress voteraddress;

  final dynamic voterinfo;
}

class Mother_linker {
  Mother_linker(List<dynamic> response)
      : voteraddress = (response[0] as _i1.EthereumAddress),
        voterinfo = (response[1] as dynamic);

  final _i1.EthereumAddress voteraddress;

  final dynamic voterinfo;
}

class Spouse_linker {
  Spouse_linker(List<dynamic> response)
      : voteraddress = (response[0] as _i1.EthereumAddress),
        voterinfo = (response[1] as dynamic);

  final _i1.EthereumAddress voteraddress;

  final dynamic voterinfo;
}

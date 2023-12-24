// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"admin","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"admins","outputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"enum Permissions.AdminRole","name":"role","type":"uint8"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"enum Permissions.AdminRole","name":"role","type":"uint8"}],"name":"requireAdmin","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"address payable","name":"_newAdmin","type":"address"},{"internalType":"enum Permissions.AdminRole","name":"role","type":"uint8"}],"name":"addAdmin","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_adminToRemove","type":"address"}],"name":"removeAdmin","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'Permissions',
);

class Permissions extends _i1.GeneratedContract {
  Permissions({
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
  Future<_i1.EthereumAddress> admin({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'f851a440'));
    final params = [];
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
  Future<Admins> admins(
    _i1.EthereumAddress $param0, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '429b62e5'));
    final params = [$param0];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Admins(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> requireAdmin(
    BigInt role, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'f405275c'));
    final params = [role];
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
  Future<String> addAdmin(
    String name,
    _i1.EthereumAddress _newAdmin,
    BigInt role, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '4cb0727a'));
    final params = [
      name,
      _newAdmin,
      role,
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
  Future<String> removeAdmin(
    _i1.EthereumAddress _adminToRemove, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '1785f53c'));
    final params = [_adminToRemove];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }
}

class Admins {
  Admins(List<dynamic> response)
      : name = (response[0] as String),
        role = (response[1] as BigInt);

  final String name;

  final BigInt role;
}

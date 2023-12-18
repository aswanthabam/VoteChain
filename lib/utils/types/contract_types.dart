import 'package:web3dart/web3dart.dart';

class ContractAddress {
  static String? voterContractAddress;
  static String? candidateContractAddress;
  static String? permissionsContractAddress;
  static String? votechainContractAddress;

  static get voterAddress =>
      EthereumAddress.fromHex(ContractAddress.voterContractAddress ?? "");
  static get candidateAddress =>
      EthereumAddress.fromHex(ContractAddress.candidateContractAddress ?? "");
  static get permissionsAddress =>
      EthereumAddress.fromHex(ContractAddress.permissionsContractAddress ?? "");
  static get votechainAddress =>
      EthereumAddress.fromHex(ContractAddress.votechainContractAddress ?? "");
}

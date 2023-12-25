import 'package:vote/services/api/system/config.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/global.dart';
import 'package:vote/services/preferences.dart';
import 'package:vote/utils/types/api_types.dart';
import 'package:vote/utils/types/contract_types.dart';

enum ClientStatus {
  success("Successfully connected to the blockchain"),
  failed("An error occured while connecting to the blockchain");

  final String message;
  const ClientStatus(this.message);
}

enum ContractInitializationStatus {
  success("Successfully initialized contracts"),
  failed("An error occured while loading contracts");

  final String message;
  const ContractInitializationStatus(this.message);
}

enum SystemConfigInitializationStatus {
  success("Successfully initialized system configs"),
  failed("An error occured while initializing system configs");

  final String message;
  const SystemConfigInitializationStatus(this.message);
}

Future<ClientStatus> initializeClient() async {
  try {
    await initializeSystemConfigs();
    await Preferences.init();
    BlockchainClient.init();
    if (await BlockchainClient.inited) {
      if (!await BlockchainClient.checkAlive()) {
        return ClientStatus.failed;
      }
      return ClientStatus.success;
    }
  } catch (err) {
    Global.logger.e("An error occured while initializing client : $err");
  }
  return ClientStatus.failed;
}

Future<SystemConfigInitializationStatus> initializeSystemConfigs() async {
  try {
    var status = await SystemConfigCall().getSystemConfigs();
    if (status == SystemConfigCallStatus.success) {
      return SystemConfigInitializationStatus.success;
    }
  } catch (err) {
    Global.logger
        .e("An unexpected error occured while initializing preferences: $err");
  }
  return SystemConfigInitializationStatus.failed;
}

Future<ContractInitializationStatus> initializeContracts() async {
  try {
    ContractAddress.voterContractAddress = SystemConfig.voterAddress;
    ContractAddress.votechainContractAddress = SystemConfig.votechainAddress;
    ContractAddress.candidateContractAddress = SystemConfig.candidateAddress;
    ContractAddress.permissionsContractAddress =
        SystemConfig.permissionsAddress;
    ContractAddress.voterReaderContractAddress =
        SystemConfig.voterReaderAddress;
    ContractAddress.linkerContractAddress = SystemConfig.linkerAddress;
    Preferences.setRpcUrl(SystemConfig.rpcUrl);
    Preferences.setWsUrl(SystemConfig.wsUrl);
    Preferences.setConractAddress();
    BlockchainClient.loadContracts();
    if (!await BlockchainClient.contract_loaded) {
      return ContractInitializationStatus.failed;
    }
    return ContractInitializationStatus.success;
  } catch (err) {
    Global.logger.e("An error occured while initializing contracts : $err");
    return ContractInitializationStatus.failed;
  }
}

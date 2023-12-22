class SystemConfig {
  static late String votechainAddress;
  static late String voterAddress;
  static late String permissionsAddress;
  static late String candidateAddress;
  static late String voterReaderAddress;
  static late String linkerAddress;
  static late String rpcUrl;
  static late String wsUrl;

  static void fromJson(Map<String, dynamic> data) {
    SystemConfig.votechainAddress = data['votechainAddress'];
    SystemConfig.voterAddress = data['voterAddress'];
    SystemConfig.permissionsAddress = data['permissionsAddress'];
    SystemConfig.candidateAddress = data['candidateAddress'];
    SystemConfig.rpcUrl = data['rpcUrl'];
    SystemConfig.wsUrl = data['wsUrl'];
    SystemConfig.voterReaderAddress = data['voterReaderAddress'];
    SystemConfig.linkerAddress = data['linkerAddress'];
  }
}

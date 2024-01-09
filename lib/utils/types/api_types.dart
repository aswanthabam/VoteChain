class SystemConfig {
  static late String votechainAddress;
  static late String voterAddress;
  static late String permissionsAddress;
  static late String candidateAddress;
  static late String voterReaderAddress;
  static late String linkerAddress;
  static late String rpcUrl;
  static late String wsUrl;
  static late String localServer;
  static late String websocketServer;

  static void fromJson(Map<String, dynamic> data) {
    SystemConfig.votechainAddress = data['votechainAddress'];
    SystemConfig.voterAddress = data['voterAddress'];
    SystemConfig.permissionsAddress = data['permissionsAddress'];
    SystemConfig.candidateAddress = data['candidateAddress'];
    SystemConfig.rpcUrl = data['rpcUrl'];
    SystemConfig.wsUrl = data['wsUrl'];
    SystemConfig.voterReaderAddress = data['voterReaderAddress'];
    SystemConfig.linkerAddress = data['linkerAddress'];
    SystemConfig.localServer = data['localServer'];
    SystemConfig.websocketServer = data['websocketServer'];
  }
}

class Election {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String constituency;
  final int nominationStatus;

  Election({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.constituency,
    required this.nominationStatus,
  });

  @override
  String toString() {
    return name;
  }

  static Election fromList(List<dynamic> data) {
    return Election(
      id: data[0].toString(),
      name: data[1],
      description: data[2],
      startDate: DateTime.fromMillisecondsSinceEpoch(data[3].toInt() * 1000),
      endDate: DateTime.fromMillisecondsSinceEpoch(data[4].toInt() * 1000),
      constituency: data[5],
      nominationStatus: data[6].toInt(),
    );
  }
}

class State {
  final String id;
  final String name;
  final String code;
  final int noOfDistricts;

  State({
    required this.id,
    required this.name,
    required this.code,
    required this.noOfDistricts,
  });

  @override
  String toString() {
    return name;
  }

  static State fromJson(Map<String, dynamic> data) {
    return State(
      id: data['id'],
      name: data['name'],
      code: data['code'],
      noOfDistricts: data['no_of_districts'],
    );
  }
}

class District {
  final String id;
  final String name;
  final String code;
  final String state;
  final int noOfConstituencies;
  final String link;
  final String? description;
  final String? image;

  District({
    required this.id,
    required this.name,
    required this.code,
    required this.state,
    required this.noOfConstituencies,
    required this.link,
    required this.description,
    required this.image,
  });

  @override
  String toString() {
    return name;
  }

  static District fromJson(Map<String, dynamic> data) {
    return District(
      id: data['id'],
      name: data['name'],
      code: data['code'],
      state: data['state'],
      noOfConstituencies: data['no_of_constituencies'],
      link: data['link'],
      description: data['description'],
      image: data['image'],
    );
  }
}

class Constituency {
  final String id;
  final String name;
  final String code;
  final String district;
  final String link;
  final String? description;
  final String? image;

  Constituency({
    required this.id,
    required this.name,
    required this.code,
    required this.district,
    required this.link,
    required this.description,
    required this.image,
  });

  @override
  String toString() {
    return name;
  }

  static Constituency fromJson(Map<String, dynamic> data) {
    return Constituency(
      id: data['id'],
      name: data['name'],
      code: data['code'],
      district: data['district'],
      link: data['link'],
      description: data['description'],
      image: data['image'],
    );
  }
}

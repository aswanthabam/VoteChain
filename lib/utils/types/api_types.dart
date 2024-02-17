import 'package:vote/utils/types/user_types.dart';
import 'package:web3dart/web3dart.dart';

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
  final int id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String constituency;
  final int nominationStatus;
  final bool isStarted;
  final bool isEnded;
  final bool isOnGoing;
  int candidatesCount;
  int nominationCount;
  int voterCount;
  int votes;
  Election({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.constituency,
    required this.nominationStatus,
    this.candidatesCount = 0,
    this.nominationCount = 0,
    this.voterCount = 0,
    this.votes = 0,
  })  : isStarted = DateTime.now().isAfter(startDate),
        isEnded = DateTime.now().isAfter(endDate),
        isOnGoing = DateTime.now().isAfter(startDate) &&
            DateTime.now().isBefore(endDate);

  @override
  String toString() {
    return name;
  }

  static Election fromList(List<dynamic> data) {
    return Election(
      id: (data[0] as BigInt).toInt(),
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

class Education {
  final String educationId;
  final String title;
  final String description;
  final String fromWhere;

  Education({
    required this.educationId,
    required this.title,
    required this.description,
    required this.fromWhere,
  });

  static Education fromJson(Map<String, dynamic> data) {
    return Education(
      educationId: data['educationId'] ?? "",
      title: data['title'] ?? "",
      description: data['description'] ?? "",
      fromWhere: data['fromWhere'] ?? "",
    );
  }
}

class Experience {
  final String experienceId;
  final String title;
  final String description;
  final String fromWhere;

  Experience({
    required this.experienceId,
    required this.title,
    required this.description,
    required this.fromWhere,
  });

  static Experience fromJson(Map<String, dynamic> data) {
    return Experience(
      experienceId: data['educationId'] ?? "",
      title: data['title'] ?? "",
      description: data['description'] ?? "",
      fromWhere: data['fromWhere'] ?? "",
    );
  }
}

class Document {
  final String title;
  final String link;

  Document({
    required this.title,
    required this.link,
  });

  static Document fromJson(Map<String, dynamic> data) {
    return Document(
      title: data['title'] ?? "",
      link: data['link'] ?? "",
    );
  }
}

class Party {
  final String partyId;
  final String name;
  final String logo;

  Party({required this.partyId, required this.name, required this.logo});

  static Party fromJson(Map<String, dynamic> data) {
    return Party(
      partyId: data['partyId'] ?? "",
      name: data['name'] ?? "",
      logo: data['logo'] ?? "",
    );
  }
}

class CandidateProfile {
  final String profileId;
  final String candidateAddress;
  final String? about;
  final String? photo;
  final String name;
  final String userId;
  final List<Education> education;
  final List<Experience> experience;
  final List<Document> documents;
  final String logo;
  final Party party;
  final String? phone;
  final String? email;
  final String? address;

  CandidateProfile({
    required this.profileId,
    required this.candidateAddress,
    required this.about,
    required this.photo,
    required this.name,
    required this.userId,
    required this.education,
    required this.experience,
    required this.documents,
    required this.logo,
    required this.party,
    required this.phone,
    required this.email,
    required this.address,
  });

  static CandidateProfile fromJson(Map<String, dynamic> data) {
    print(data);
    return CandidateProfile(
      profileId: data['profileId'] ?? "",
      candidateAddress: data['candidateAddress'] ?? "",
      about: data['about'],
      photo: data['photo'],
      name: data['name'] ?? "",
      userId: data['userId'] ?? "",
      education: ((data['education'] ?? []) as List<dynamic>)
          .map((e) => Education.fromJson(e))
          .toList(),
      experience: ((data['experience'] ?? []) as List<dynamic>)
          .map((e) => Experience.fromJson(e))
          .toList(),
      documents: ((data['documents'] ?? []) as List<dynamic>)
          .map((e) => Document.fromJson(e))
          .toList(),
      logo: data['logo'] ?? "",
      party: Party.fromJson(data['party']),
      phone: data['phone'],
      email: data['email'],
      address: data['address'],
    );
  }
}

class CandidateBlockchainInfo {
  final EthereumAddress address;
  final VoterInfo info;

  CandidateBlockchainInfo({
    required this.address,
    required this.info,
  });

  static CandidateBlockchainInfo fromList(List<dynamic> data) {
    return CandidateBlockchainInfo(
      address: data[0],
      info: VoterInfo.fromList(data[1]),
    );
  }

  @override
  String toString() {
    return "Address: ${address.hex}, Info: $info";
  }
}

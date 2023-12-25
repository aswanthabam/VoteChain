import 'package:vote/utils/types/types.dart';

class PersonalInfo extends JsonType {
  String firstName;
  String middleName;
  String lastName;
  String dob;

  PersonalInfo({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "dob": dob,
    };
  }

  static PersonalInfo fromList(List<dynamic> data) {
    return PersonalInfo(
        firstName: data[0],
        middleName: data[1],
        lastName: data[2],
        dob: data[3]);
  }
}

class AddressInfo extends JsonType {
  String state;
  String district;
  String locality;
  String ward;
  String houseName;
  String houseNumber;
  String street;
  String pincode;

  AddressInfo({
    required this.state,
    required this.district,
    required this.locality,
    required this.ward,
    required this.houseName,
    required this.houseNumber,
    required this.street,
    required this.pincode,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "district": district,
      "locality": locality,
      "ward": ward,
      "house_name": houseName,
      "house_number": houseNumber,
      "street": street,
      "pincode": pincode,
    };
  }

  static AddressInfo fromList(List<dynamic> data) {
    return AddressInfo(
        state: data[0],
        district: data[1],
        locality: data[2],
        ward: data[3],
        houseName: data[4],
        houseNumber: data[5],
        street: data[6],
        pincode: data[7]);
  }
}

class ContactInfo extends JsonType {
  String phone;
  String email;

  ContactInfo({
    required this.phone,
    required this.email,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "email": email,
    };
  }

  static ContactInfo fromList(List<dynamic> data) {
    return ContactInfo(phone: data[0], email: data[1]);
  }
}

class VoterInfo extends JsonType {
  String aadharNumber;
  PersonalInfo personalInfo;
  ContactInfo contactInfo;
  AddressInfo permanentAddress;
  AddressInfo currentAddress;
  bool married;
  bool orphan;

  VoterInfo({
    required this.aadharNumber,
    required this.personalInfo,
    required this.contactInfo,
    required this.permanentAddress,
    required this.currentAddress,
    required this.married,
    required this.orphan,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "aadhar_number": aadharNumber,
      "personal_info": personalInfo.toJson(),
      "contact_info": contactInfo.toJson(),
      "permeant_address": permanentAddress.toJson(),
      "current_address": currentAddress.toJson(),
      "married": married,
      "orphan": orphan,
    };
  }

  static VoterInfo fromList(List<dynamic> data) {
    return VoterInfo(
        aadharNumber: data[0],
        personalInfo: PersonalInfo.fromList(data[1]),
        contactInfo: ContactInfo.fromList(data[2]),
        permanentAddress: AddressInfo.fromList(data[3]),
        currentAddress: AddressInfo.fromList(data[4]),
        married: data[5],
        orphan: data[6]);
  }
}

class UserRegisteredData {}

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
}

class VoterInfo extends JsonType {
  PersonalInfo personalInfo;
  ContactInfo contactInfo;
  AddressInfo permeantAddress;
  AddressInfo currentAddress;
  bool married;
  bool orphan;

  VoterInfo({
    required this.personalInfo,
    required this.contactInfo,
    required this.permeantAddress,
    required this.currentAddress,
    required this.married,
    required this.orphan,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "personal_info": personalInfo.toJson(),
      "contact_info": contactInfo.toJson(),
      "permeant_address": permeantAddress.toJson(),
      "current_address": currentAddress.toJson(),
      "married": married,
      "orphan": orphan,
    };
  }
}

class UserRegisteredData {}

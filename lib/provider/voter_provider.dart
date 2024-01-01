import 'package:flutter/material.dart';
import 'package:vote/utils/types/user_types.dart';
import 'package:web3dart/web3dart.dart';

class VoterModal extends ChangeNotifier {
  EthPrivateKey? _privateKey;

  String _aadharNumber = "";
  String _password = "";
  String _pin = "";
  String _firstName = "";
  String _middleName = "";
  String _lastName = "";
  String _dob = "";
  String _email = "";
  String _phone = "";
  String _permanentAddressState = "";
  String _permanentAddressDistrict = "";
  String _permanentAddressLocality = "";
  String _permanentAddressWard = "";
  String _permanentAddressHouseName = "";
  String _permanentAddressHouseNumber = "";
  String _permanentAddressStreet = "";
  String _permanentAddressPincode = "";
  String _currentAddressState = "";
  String _currentAddressDistrict = "";
  String _currentAddressLocality = "";
  String _currentAddressWard = "";
  String _currentAddressHouseName = "";
  String _currentAddressStreet = "";
  String _currentAddressHouseNumber = "";
  String _currentAddressPincode = "";
  bool _married = false;
  bool _orphan = false;

  EthereumAddress? get address => _privateKey?.address;
  EthPrivateKey? get privateKey => _privateKey;
  String get aadharNumber => _aadharNumber;
  String get password => _password;
  String get pin => _pin;
  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get dob => _dob;
  String get email => _email;
  String get phone => _phone;
  String get permanentAddressState => _permanentAddressState;
  String get permanentAddressDistrict => _permanentAddressDistrict;
  String get permanentAddressLocality => _permanentAddressLocality;
  String get permanentAddressWard => _permanentAddressWard;
  String get permanentAddressHouseName => _permanentAddressHouseName;
  String get permanentAddressHouseNumber => _permanentAddressHouseNumber;
  String get permanentAddressStreet => _permanentAddressStreet;
  String get permanentAddressPincode => _permanentAddressPincode;
  String get currentAddressState => _currentAddressState;
  String get currentAddressDistrict => _currentAddressDistrict;
  String get currentAddressLocality => _currentAddressLocality;
  String get currentAddressWard => _currentAddressWard;
  String get currentAddressHouseName => _currentAddressHouseName;
  String get currentAddressHouseNumber => _currentAddressHouseNumber;
  String get currentAddressStreet => _currentAddressStreet;
  String get currentAddressPincode => _currentAddressPincode;
  bool get married => _married;
  bool get orphan => _orphan;

  PersonalInfo get personalInfo => PersonalInfo(
        firstName: _firstName,
        middleName: _middleName,
        lastName: _lastName,
        dob: _dob,
      );

  ContactInfo get contactInfo => ContactInfo(
        email: _email,
        phone: _phone,
      );

  AddressInfo get permanentAddress => AddressInfo(
        state: _permanentAddressState,
        district: _permanentAddressDistrict,
        locality: _permanentAddressLocality,
        ward: _permanentAddressWard,
        houseName: _permanentAddressHouseName,
        houseNumber: _permanentAddressHouseNumber,
        street: _permanentAddressStreet,
        pincode: _permanentAddressPincode,
      );

  AddressInfo get currentAddress => AddressInfo(
        state: _currentAddressState,
        district: _currentAddressDistrict,
        locality: _currentAddressLocality,
        ward: _currentAddressWard,
        houseName: _currentAddressHouseName,
        houseNumber: _currentAddressHouseNumber,
        street: _currentAddressStreet,
        pincode: _currentAddressPincode,
      );

  VoterInfo get voterInfo => VoterInfo(
        aadharNumber: _aadharNumber,
        personalInfo: personalInfo,
        permanentAddress: permanentAddress,
        currentAddress: currentAddress,
        contactInfo: contactInfo,
        married: _married,
        orphan: _orphan,
      );

  set privatekey(EthPrivateKey key) {
    _privateKey = key;
    notifyListeners();
  }

  set aadharNumber(String aadhar) {
    _aadharNumber = aadhar;
    notifyListeners();
  }

  set password(String pass) {
    _password = pass;
    notifyListeners();
  }

  set firstName(String name) {
    _firstName = name;
    notifyListeners();
  }

  set middleName(String name) {
    _middleName = name;
    notifyListeners();
  }

  set lastName(String name) {
    _lastName = name;
    notifyListeners();
  }

  set dob(String dob) {
    _dob = dob;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set phone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  set permanentAddressState(String state) {
    _permanentAddressState = state;
    notifyListeners();
  }

  set permanentAddressDistrict(String district) {
    _permanentAddressDistrict = district;
    notifyListeners();
  }

  set permanentAddressLocality(String locality) {
    _permanentAddressLocality = locality;
    notifyListeners();
  }

  set permanentAddressWard(String ward) {
    _permanentAddressWard = ward;
    notifyListeners();
  }

  set permanentAddressHouseName(String houseName) {
    _permanentAddressHouseName = houseName;
    notifyListeners();
  }

  set permanentAddressHouseNumber(String houseNumber) {
    _permanentAddressHouseNumber = houseNumber;
    notifyListeners();
  }

  set permanentAddressStreet(String street) {
    _permanentAddressStreet = street;
    notifyListeners();
  }

  set permanentAddressPincode(String pincode) {
    _permanentAddressPincode = pincode;
    notifyListeners();
  }

  set currentAddressState(String state) {
    _currentAddressState = state;
    notifyListeners();
  }

  set currentAddressDistrict(String district) {
    _currentAddressDistrict = district;
    notifyListeners();
  }

  set currentAddressLocality(String locality) {
    _currentAddressLocality = locality;
    notifyListeners();
  }

  set currentAddressWard(String ward) {
    _currentAddressWard = ward;
    notifyListeners();
  }

  set currentAddressHouseName(String houseName) {
    _currentAddressHouseName = houseName;
    notifyListeners();
  }

  set currentAddressHouseNumber(String houseNumber) {
    _currentAddressHouseNumber = houseNumber;
    notifyListeners();
  }

  set currentAddressStreet(String street) {
    _currentAddressStreet = street;
    notifyListeners();
  }

  set currentAddressPincode(String pincode) {
    _currentAddressPincode = pincode;
    notifyListeners();
  }

  set married(bool value) {
    _married = value;
    notifyListeners();
  }

  set orphan(bool value) {
    _orphan = value;
    notifyListeners();
  }

  set pin(String pin) {
    _pin = pin;
    notifyListeners();
  }
}

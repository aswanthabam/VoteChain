// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/Voter.g.dart';
import 'package:vote/screens/pages/register/election_details/one_election.dart';
import 'package:vote/screens/pages/register/personal_information/one_personal.dart';
import 'package:vote/screens/pages/register/personal_information/three_personal.dart';
import 'package:vote/screens/pages/register/personal_information/two_personal.dart';
import 'package:vote/screens/pages/register/register_info.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/paginated_views/paginated_views.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/utils/types/user_types.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int step = 0, totalstep = 3;
  String uid = "";
  String otp = "";
  String password = "";
  Pagination pagination = Pagination(pages: [
    RegisterInfoPage(),
    RegisterPersonalInfoOnePage(),
    RegisterPersonalInfoTwoPage(),
    RegisterPersonalInfoThreePage(),
    RegisterElectionDetailsOnePage(),
  ]);

  void submitRegister() async {
    BlockchainClient client = BlockchainClient();
    BlockchainClient.init();
    await BlockchainClient.inited!;
    client.loadContracts();
    print(await BlockchainClient.contract_loaded!);
    Future.delayed(const Duration(seconds: 2));
    print(Contracts.voter);
    VoterHelper helper = VoterHelper(Contracts.voter!);
    PersonalInfo personalInfo = PersonalInfo(
        firstName: "firstName",
        middleName: "middleName",
        lastName: "lastName",
        dob: "dob");
    ContactInfo contactInfo = ContactInfo(email: "email", phone: "phone");
    AddressInfo permeantAddress = AddressInfo(
        state: "state",
        district: "district",
        locality: "locality",
        ward: "ward",
        houseName: "houseName",
        houseNumber: "houseNumber",
        street: "street",
        pincode: "pincode");
    await helper.registerVoter(VoterInfo(
        personalInfo: personalInfo,
        contactInfo: contactInfo,
        permeantAddress: permeantAddress,
        currentAddress: permeantAddress,
        married: false,
        orphan: false));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: -100,
          right: -100,
          child: Image.asset(
            'src/images/asset/ellipse_green.png',
            width: 200,
          )),
      Positioned(
          left: 20,
          top: 30,
          child: IconButton(
              onPressed: () {
                // clearStep();
                setState(() {
                  pagination.prev();
                });
                // pagination.prev();
                // if (!preStep()) Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios))),
      Positioned(
          right: 20,
          top: 30,
          child: IconButton(
              onPressed: () {}, icon: const Icon(Icons.help_outline_outlined))),
      Positioned(
          top: 100,
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            children: [
              Expanded(child: pagination.widget),
              getPrimaryAsyncButton(context, () async {
                if (pagination.hasNext()) {
                  setState(() {
                    pagination.next();
                  });
                  return true;
                } else {
                  submitRegister();
                  return true;
                }
              }, "Continue", "Loading", "An Error Occured", "Continue",
                  MediaQuery.of(context).size.width - 20)
            ],
          )),
    ]));
  }
}

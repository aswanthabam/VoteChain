// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/final/confirm_phrase.dart';
import 'package:vote/screens/pages/register/final/password_adder.dart';
import 'package:vote/screens/pages/register/final/pin_add.dart';
import 'package:vote/screens/pages/register/personal_information/one_personal.dart';
import 'package:vote/screens/pages/register/personal_information/two_personal.dart';
import 'package:vote/screens/pages/register/personal_information/uid.dart';
import 'package:vote/screens/pages/register/register_info.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/paginated_views/paginated_views.dart'
    as pagging;
import 'package:vote/services/api/ethers/ethers.dart';
import 'package:vote/services/api/user.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/utils/encryption.dart';
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
  String pin = "";
  pagging.Pagination pagination = pagging.Pagination(pages: <FormPage>[
    RegisterInfoPage(),
    RegisterUIDPage(),
    RegisterPersonalInfoOnePage(),
    RegisterPersonalInfoTwoPage(),
    // RegisterPersonalInfoThreePage(),
    // RegisterElectionDetailsOnePage(),
    PasswordAdderPage(),
    PinAddPage(),
    PhraseConfirmPage(),
  ]);

  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  AddressInfo? permenentAddressInfo;
  AddressInfo? currentAddressInfo;
  String? aadhar;

  void submitRegister() async {
    VoterHelper helper = VoterHelper();
    var res = await EthersCall().requestEthers();
    if (res != FundAccountCallStatus.success) {
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                message: res.message,
                bottomButtons: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Continue"))
                ],
              ));
      return;
    }
    var sts = await helper.registerVoter(VoterInfo(
        aadharNumber: aadhar!,
        personalInfo: personalInfo!,
        contactInfo: contactInfo!,
        permanentAddress: permenentAddressInfo!,
        currentAddress: currentAddressInfo!,
        married: false,
        orphan: false));
    if (sts == VoterRegistrationStatus.success) {
      VoteChainWallet.saveWallet(pin);
      var sts2 = await UserAuthCall().registerUser(
          uid: aadhar!,
          aadhar: aadhar!,
          enc1: await encrypt(VoteChainWallet.mnemonic!.sublist(4, 8).join(' '),
                  password) ??
              "errorstring:enc",
          enc2: await encrypt(
                  VoteChainWallet.mnemonic!.sublist(8, 12).join(' '),
                  password) ??
              "erronstring:enc");
      if (sts2 != RegisterUserCallStatus.success) {
        showDialog(
            context: context,
            builder: (context) => TextPopup(
                  message: sts2.message,
                  bottomButtons: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Continue"))
                  ],
                ));
        return;
      }
      await helper.fetchInfo();
    }
    print(sts);
    showDialog(
        context: context,
        builder: (context) => TextPopup(
              message: sts.message,
              bottomButtons: [
                TextButton(
                    onPressed: () {
                      if (sts != VoterRegistrationStatus.success) {
                        Navigator.of(context).pop();
                        return;
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'home', (route) => false);
                    },
                    child: const Text("Continue"))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
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
                        if (pagination.hasPrev()) {
                          setState(() {
                            pagination.prev();
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios))),
              Positioned(
                  right: 20,
                  top: 30,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.help_outline_outlined))),
              Positioned(
                  top: 100,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: pagination.widget),
                      getPrimaryAsyncButton(context, () async {
                        VoterHelper helper = VoterHelper();
                        await helper.fetchInfo();
                        FormPage page = pagination
                            .pages[pagination.currentIndex]! as FormPage;
                        FormPageStatus sts = page.validate();
                        if (sts.status) {
                          switch (pagination.currentIndex) {
                            case 0:
                              break;
                            case 2:
                              aadhar = page.validatedData as String;
                              break;
                            case 3:
                              personalInfo = (page.validatedData
                                      as RegisterPersonalInfoPageData)
                                  .personalInfo;
                              contactInfo = (page.validatedData
                                      as RegisterPersonalInfoPageData)
                                  .contactInfo;
                              break;
                            case 4:
                              permenentAddressInfo =
                                  (page.validatedData as RegisterPageTwoData)
                                      .permenentAddressInfo;
                              currentAddressInfo =
                                  (page.validatedData as RegisterPageTwoData)
                                      .currentAddressInfo;
                              break;
                            case 5:
                              password = page.validatedData as String;
                              break;
                            case 6:
                              pin = page.validatedData as String;
                              break;
                            case 7:
                              showDialog(
                                  context: context,
                                  builder: (context) => TextPopup(
                                        message: sts.message,
                                        bottomButtons: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "I Confirm, Continue",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      ));
                              break;
                            default:
                          }
                          if (pagination.hasNext()) {
                            setState(() {
                              pagination.next();
                            });
                            return true;
                          } else {
                            submitRegister();
                            return true;
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => TextPopup(
                                    message: sts.message,
                                    bottomButtons: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Continue"))
                                    ],
                                  ));
                        }

                        return true;
                      }, "Continue", "Loading", "An Error Occured", "Continue",
                          MediaQuery.of(context).size.width - 20)
                    ],
                  )),
            ]),
          ),
        ));
  }
}

class FormPageStatus {
  bool status;
  String message;
  FormPageStatus(this.status, this.message);
}

abstract class FormPage<T> extends pagging.Page {
  T? validatedData;
  FormPageStatus validate();
}

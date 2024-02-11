// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/callbacks.dart';
import 'package:vote/screens/pages/register/final/confirm_phrase.dart';
import 'package:vote/screens/pages/register/final/face_register.dart';
import 'package:vote/screens/pages/register/final/password_adder.dart';
import 'package:vote/screens/pages/register/final/pin_add.dart';
import 'package:vote/screens/pages/register/personal_information/constituency.dart';
import 'package:vote/screens/pages/register/personal_information/one_personal.dart';
import 'package:vote/screens/pages/register/personal_information/two_personal.dart';
import 'package:vote/screens/pages/register/personal_information/uid.dart';
import 'package:vote/screens/pages/register/register_info.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/paginated_views/paginated_views.dart'
    as pagging;
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
  String pin = "";

  late pagging.Pagination pagination;

  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  AddressInfo? permenentAddressInfo;
  AddressInfo? currentAddressInfo;
  String? aadhar;
  bool continueButtonVisible = true;
  String faceId = "";
  String appKey = "";

  void hideContinueButton() {
    setState(() {
      continueButtonVisible = false;
    });
  }

  void forcefullyGoNext() {
    setState(() {
      onNext();
    });
  }

  Future<bool> onNext() async {
    VoterHelper helper = VoterHelper();
    await helper.fetchInfo();
    FormPage page = pagination.pages[pagination.currentIndex]! as FormPage;
    FormPageStatus sts = page.validate();
    print(pagination.pages.length);
    if (sts.status) {
      if (pagination.currentIndex < pagination.pages.length - 1) {
        setState(() {
          continueButtonVisible = true;
          pagination.next(rebuild: false);
        });
        return true;
      } else if (pagination.currentIndex == pagination.pages.length - 1) {
        Completer<bool> completer = Completer<bool>();
        BuildContext outerContext = context;
        showDialog(
            context: context,
            builder: (context) => TextPopup(
                  message: sts.message,
                  bottomButtons: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          submitRegister(context.read<VoterModal>())
                              .then((value) {
                            if (value.success) {
                              if (value.faceId != null) {
                                setState(() {
                                  faceId = value.faceId!;
                                });
                                if (value.appKey != null) {
                                  setState(() {
                                    appKey = value.appKey!;
                                  });
                                  continueButtonVisible = true;
                                  pagination.next();
                                  completer.complete(true);
                                } else {
                                  showDialog(
                                      context: outerContext,
                                      builder: (context) => TextPopup(
                                            message:
                                                "An error occured while getting the app key",
                                            bottomButtons: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    completer.complete(false);
                                                  },
                                                  child: const Text("Continue"))
                                            ],
                                          ));
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => TextPopup(
                                          message:
                                              "There was an error with the registration, the registration got completed, but some issues occured in the middle, please contact admin",
                                          bottomButtons: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  completer.complete(false);
                                                },
                                                child: const Text("Ok"))
                                          ],
                                        ));
                              }
                            } else {
                              showDialog(
                                  context: outerContext,
                                  builder: (context) => TextPopup(
                                        message: value.message,
                                        bottomButtons: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                completer.complete(false);
                                              },
                                              child: const Text("Continue"))
                                        ],
                                      ));
                            }
                          });
                        },
                        child: const Text(
                          "I Confirm, Continue",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ));
        return await completer.future;
      } else {
        Completer<bool> completer = Completer<bool>();
        showDialog(
            context: context,
            builder: (context) => TextPopup(
                  message:
                      "Your registration is complete. Please wait until the admin approves your registration.",
                  bottomButtons: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          completer.complete(true);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'home', (route) => false);
                        },
                        child: const Text("Continue"))
                  ],
                ));
        await completer.future;
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
  }

  @override
  void initState() {
    super.initState();
    pagination = pagging.Pagination(pages: <FormPage>[
      RegisterInfoPage(),
      RegisterUIDPage(),
      RegisterPersonalInfoOnePage(),
      RegisterPersonalInfoTwoPage(),
      ConstituencySelectorPage(),
      // RegisterPersonalInfoThreePage(),
      // RegisterElectionDetailsOnePage(),
      PasswordAdderPage(),
      PinAddPage(),
      PhraseConfirmPage(), // -2
      FaceRegisterPage(
          hideContinueButton: hideContinueButton,
          faceId: getFaceId,
          next: forcefullyGoNext,
          appKey: getAppKey), // -1
    ]);
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
                          continueButtonVisible = true;
                          setState(() {
                            pagination.prev(rebuild: false);
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
                      continueButtonVisible
                          ? getPrimaryAsyncButton(
                              context,
                              onNext,
                              "Continue",
                              "Loading",
                              "An Error Occured",
                              "Continue",
                              MediaQuery.of(context).size.width - 20)
                          : const SizedBox()
                    ],
                  )),
            ]),
          ),
        ));
  }

  String? getFaceId() {
    return faceId;
  }

  String? getAppKey() {
    return appKey;
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

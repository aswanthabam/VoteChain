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

  pagging.Pagination pagination = pagging.Pagination(pages: <FormPage>[
    FaceRegisterPage(),
    RegisterInfoPage(),
    RegisterUIDPage(),
    RegisterPersonalInfoOnePage(),
    RegisterPersonalInfoTwoPage(),
    ConstituencySelectorPage(),
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

  Future<bool> onNext() async {
    VoterHelper helper = VoterHelper();
    await helper.fetchInfo();
    FormPage page = pagination.pages[pagination.currentIndex]! as FormPage;
    FormPageStatus sts = page.validate();
    if (sts.status) {
      if (pagination.hasNext()) {
        setState(() {
          pagination.next(rebuild: false);
        });
        return true;
      } else {
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
                              completer.complete(true);
                              showDialog(
                                  context: outerContext,
                                  builder: (context) => TextPopup(
                                        message: value.message,
                                        bottomButtons: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        'home',
                                                        (route) => false);
                                              },
                                              child: const Text("Continue"))
                                        ],
                                      ));
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
                      getPrimaryAsyncButton(
                          context,
                          onNext,
                          "Continue",
                          "Loading",
                          "An Error Occured",
                          "Continue",
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

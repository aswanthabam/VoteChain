// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/election_details/one_election.dart';
import 'package:vote/screens/pages/register/personal_information/one_personal.dart';
import 'package:vote/screens/pages/register/personal_information/three_personal.dart';
import 'package:vote/screens/pages/register/personal_information/two_personal.dart';
import 'package:vote/screens/pages/register/register_info.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/paginated_views/paginated_views.dart'
    as pagging;
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
  pagging.Pagination pagination = pagging.Pagination(pages: <FormPage>[
    RegisterInfoPage(),
    RegisterPersonalInfoOnePage(),
    RegisterPersonalInfoTwoPage(),
    RegisterPersonalInfoThreePage(),
    RegisterElectionDetailsOnePage(),
  ]);

  PersonalInfo? personalInfo;
  ContactInfo? contactInfo;
  AddressInfo? permenentAddressInfo;
  AddressInfo? currentAddressInfo;

  void submitRegister() async {}

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
                        FormPage page = pagination
                            .pages[pagination.currentIndex]! as FormPage;
                        FormPageStatus sts = page.validate();
                        if (sts.status) {
                          switch (pagination.currentIndex) {
                            case 0:
                              break;
                            case 2:
                              personalInfo = (page.validatedData
                                      as RegisterPersonalInfoPageData)
                                  .personalInfo;
                              contactInfo = (page.validatedData
                                      as RegisterPersonalInfoPageData)
                                  .contactInfo;
                              break;
                            case 3:
                              permenentAddressInfo =
                                  (page.validatedData as RegisterPageTwoData)
                                      .permenentAddressInfo;
                              currentAddressInfo =
                                  (page.validatedData as RegisterPageTwoData)
                                      .currentAddressInfo;
                              break;
                            case 4:
                              break;
                            case 5:
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

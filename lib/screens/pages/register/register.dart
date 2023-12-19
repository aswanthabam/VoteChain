// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/election_details/one_election.dart';
import 'package:vote/screens/pages/register/personal_information/one_personal.dart';
import 'package:vote/screens/pages/register/personal_information/three_personal.dart';
import 'package:vote/screens/pages/register/personal_information/two_personal.dart';
import 'package:vote/screens/pages/register/register_info.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/paginated_views/paginated_views.dart'
    as pagging;

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

  void submitRegister() async {}

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
                FormPage page =
                    pagination.pages[pagination.currentIndex]! as FormPage;
                FormPageStatus sts = page.validate();
                if (sts.status) {
                  print(page.validatedData);
                  if (pagination.hasNext()) {
                    setState(() {
                      pagination.next();
                    });
                    return true;
                  } else {
                    submitRegister();
                    return true;
                  }
                } else
                  print(sts.message);

                return true;
              }, "Continue", "Loading", "An Error Occured", "Continue",
                  MediaQuery.of(context).size.width - 20)
            ],
          )),
    ]));
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

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/utils/paginated_views.dart';
import '../../components/buttons/async_button.dart';

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
  Pagination pagination = Pagination(pages: [SampleWidget(), SampleWidget()]);
  @override
  void initState() {
    super.initState();
  }

  /* Get the current widget
    Eg : OTP widget if in the otp entering step */
  Widget getCurrentWidget() {
    switch (step) {
      default:
        return const Expanded(
          child: SizedBox(),
        );
    }
  }

  /* Go to te next step 
    just increment the step value the view will be automatically re rendered */
  void nextStep() {
    if (step < totalstep - 1) {
      setState(() {
        step++;
      });
    }
  }

  /* Go to previous step */
  bool preStep() {
    if (step > 0) {
      setState(() {
        step--;
      });
      return true;
    } else {
      return false;
    }
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
                if (!preStep()) Navigator.pop(context);
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
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  pagination.next();
                });
                return true;
              }, "Continue", "Loading", "Failed", "Success",
                  MediaQuery.of(context).size.width - 20)
            ],
          )),
    ]));
  }
}

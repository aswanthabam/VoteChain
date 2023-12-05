import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/date_field.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPersonalInfoOnePage extends paging.Page {
  @override
  Widget build(paging.PaginationContext state) {
    return RegisterPersonalInfoOneWidget(pageState: this);
  }
}

class RegisterPersonalInfoOneWidget extends StatefulWidget {
  const RegisterPersonalInfoOneWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<RegisterPersonalInfoOneWidget> createState() =>
      _RegisterPersonalInfoOneWidgetState();
}

class _RegisterPersonalInfoOneWidgetState
    extends State<RegisterPersonalInfoOneWidget> {
  InputFieldHandler firstName = InputFieldHandler(label: "First Name");
  InputFieldHandler middleName = InputFieldHandler(label: "Middle Name");
  InputFieldHandler lastName = InputFieldHandler(label: "Last Name");
  InputFieldHandler phoneNumber = InputFieldHandler(label: "Phone Number");
  InputFieldHandler email = InputFieldHandler(label: "Email");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Personal Details",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child:
                        const StatusBar(fractions: 4, current: 1, padding: 0),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UnderlinedText(
                          heading: "Name",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter Your First Name, Second Name, Middle Name (If,). The name want to be entered in both English and your local language. Know more about loacal languages"),
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Fill in English",
                          fontSize: 13,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color.fromARGB(255, 128, 129, 128),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        firstName.widget,
                        const SizedBox(height: 20),
                        middleName.widget,
                        const SizedBox(height: 20),
                        lastName.widget,
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Date of Birth",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter Your First Name, Second Name, Middle Name (If,). The name want to be entered in both English and your local language. Know more about loacal languages"),
                        const SizedBox(height: 20),
                        DateField(label: "Select Date", onDateSelected: (v) {}),
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Contact Details",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Phone number",
                          fontSize: 13,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color.fromARGB(255, 128, 129, 128),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter your 10 digit phone number. This number want to be verified by OTP. This number will be used as your Phone Number for Two Factor Authentication."),
                        const SizedBox(
                          height: 20,
                        ),
                        phoneNumber.widget,
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "E Mail Address",
                          fontSize: 13,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color.fromARGB(255, 128, 129, 128),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter your email ID. This field is optional, this will be used as your secondary authentication method for 2FA. Know More"),
                        const SizedBox(height: 20),
                        email.widget,
                      ],
                    ),
                  )
                ])));
  }
}

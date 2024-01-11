import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/date_field.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import 'package:vote/utils/types/user_types.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPersonalInfoPageData {
  PersonalInfo personalInfo;
  ContactInfo contactInfo;
  RegisterPersonalInfoPageData(
      {required this.personalInfo, required this.contactInfo});
}

class RegisterPersonalInfoOnePage
    extends FormPage<RegisterPersonalInfoPageData> {
  @override
  // ignore: overridden_fields
  RegisterPersonalInfoPageData? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? firstName = getState<InputFieldHandler>("firstName");
    InputFieldHandler? middleName = getState<InputFieldHandler>("middleName");
    InputFieldHandler? lastName = getState<InputFieldHandler>("lastName");
    InputFieldHandler? phoneNumber = getState<InputFieldHandler>("phoneNumber");
    InputFieldHandler? email = getState<InputFieldHandler>("email");
    String? dob = getState<String?>("dob");

    if (firstName == null ||
        lastName == null ||
        phoneNumber == null ||
        email == null ||
        dob == null ||
        firstName.text == "" ||
        lastName.text == "" ||
        phoneNumber.text == "" ||
        email.text == "") {
      return FormPageStatus(false,
          "Please fill all the required fields to continue. The fields marked with * are required");
    }

    if (phoneNumber.text.length != 10 ||
        phoneNumber.text.contains(RegExp(r'[a-zA-Z]'))) {
      return FormPageStatus(false,
          "Please enter a valid phone number, A phone number should be 10 digits long and should not contain any alphabets (country code is not required)\n This number will be used for 2FA, so be careful when filling it.");
    }
    if (email.text != "" && !email.text.contains("@")) {
      return FormPageStatus(false,
          "Please enter a valid email address, this address will be used for 2FA, so be careful when filling it.");
    }
    var personalInfo = PersonalInfo(
      firstName: firstName.text,
      middleName: middleName == null ? "" : middleName.text,
      lastName: lastName.text,
      dob: dob,
    );
    var contactInfo = ContactInfo(phone: phoneNumber.text, email: email.text);
    validatedData = RegisterPersonalInfoPageData(
        personalInfo: personalInfo, contactInfo: contactInfo);
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

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
  late InputFieldHandler firstName = InputFieldHandler(label: "");
  late InputFieldHandler middleName = InputFieldHandler(label: "");
  late InputFieldHandler lastName = InputFieldHandler(label: "");
  late InputFieldHandler phoneNumber = InputFieldHandler(label: "");
  late InputFieldHandler email = InputFieldHandler(label: "");
  @override
  void initState() {
    super.initState();
    firstName = InputFieldHandler(
        label: "First Name *",
        initialValue: Provider.of<VoterModal>(context, listen: false).firstName,
        onChanged: (v) {
          Provider.of<VoterModal>(context, listen: false).firstName =
              firstName.text;
          widget.pageState.setState("firstName", firstName);
        });
    middleName = InputFieldHandler(
        label: "Middle Name",
        initialValue:
            Provider.of<VoterModal>(context, listen: false).middleName,
        onChanged: (v) {
          Provider.of<VoterModal>(context, listen: false).middleName =
              middleName.text;
          widget.pageState.setState("middleName", middleName);
        });
    lastName = InputFieldHandler(
        label: "Last Name *",
        initialValue: Provider.of<VoterModal>(context, listen: false).lastName,
        onChanged: (v) {
          Provider.of<VoterModal>(context, listen: false).lastName =
              lastName.text;
          widget.pageState.setState("lastName", lastName);
        });
    phoneNumber = InputFieldHandler(
        label: "Phone Number *",
        initialValue: Provider.of<VoterModal>(context, listen: false).phone,
        onChanged: (v) {
          Provider.of<VoterModal>(context, listen: false).phone =
              phoneNumber.text;
          widget.pageState.setState("phoneNumber", phoneNumber);
        });
    email = InputFieldHandler(
        label: "Email *",
        initialValue: Provider.of<VoterModal>(context, listen: false).email,
        onChanged: (v) {
          Provider.of<VoterModal>(context, listen: false).email = email.text;
          widget.pageState.setState("email", email);
        });

    widget.pageState.bindWidgetState(setState);
    // widget.pageState.setState("middleName", middleName);
    // widget.pageState.setState("lastName", lastName);
    // widget.pageState.setState("phoneNumber", phoneNumber);
    // widget.pageState.setState("email", email);
    // widget.pageState.setState("dob", );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        DateField(
                            label: "Select Date *",
                            onDateSelected: (v) {
                              Provider.of<VoterModal>(context, listen: false)
                                  .dob = v.toIso8601String();
                              widget.pageState.setState<String>(
                                  "dob",
                                  Provider.of<VoterModal>(context,
                                          listen: false)
                                      .dob);
                            }),
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

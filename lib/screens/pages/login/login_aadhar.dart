import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/input_components/keyboard.dart';
import 'package:vote/screens/widgets/input_components/valueDisplayer.dart';
import '../../widgets/paginated_views/paginated_views.dart' as paging;

class LoginAadharPage extends FormPage<String> {
  @override
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? aadhar = getState<InputFieldHandler>("aadhar");
    if (aadhar == null || aadhar.text.isEmpty || aadhar.text.length != 12) {
      return FormPageStatus(false,
          "The Aadhar Number you entered is not valid, Aadhar Number must contain 12 characters");
    }
    validatedData = aadhar.text;
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return LoginAadharWidget(pageState: this);
  }
}

class LoginAadharWidget extends StatefulWidget {
  const LoginAadharWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<LoginAadharWidget> createState() => _LoginAadharWidgetState();
}

class _LoginAadharWidgetState extends State<LoginAadharWidget> {
  InputFieldHandler aadhar = InputFieldHandler(label: 'Aadhar Number *');
  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
    widget.pageState.setState("aadhar", aadhar);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter Your 12 Digit Aadhar Number",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.black)),
                const SizedBox(height: 20),
                const Text(
                    "Enter your 12 digit aadhar number you entered during registration process, this is required for logging in to votechain."),
                const SizedBox(height: 20),
                ValueDisplayer(
                    value: aadhar.text,
                    length: 12,
                    fill: '0',
                    divide: const [4, 4, 4]),
              ],
            ),
          ),
          const Spacer(),
          KeyBoard(onPressed: (String value) {
            setState(() {
              if (value == 'clr') {
                aadhar.text = '';
              } else if (value == 'bck') {
                if (aadhar.text.isNotEmpty) {
                  aadhar.text =
                      aadhar.text.substring(0, aadhar.text.length - 1);
                }
              } else if (aadhar.text.length < 12) {
                aadhar.text += value;
              }
            });
          }),
        ],
      ),
    );
  }
}

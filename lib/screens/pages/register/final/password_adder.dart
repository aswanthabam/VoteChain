import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class PasswordAdderPage extends FormPage<String> {
  @override
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? password = getState<InputFieldHandler>("password");
    if (password == null ||
        password.text.isEmpty ||
        password.text.length < 8 ||
        RegExp(r'[0-9]').hasMatch(password.text) == false ||
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password.text) == false) {
      return FormPageStatus(false,
          "The password you entered is not valid, Password must contain at least 8 characters, one number and one special character");
    }
    validatedData = password.text;
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return PasswordAdderWidget(pageState: this);
  }
}

class PasswordAdderWidget extends StatefulWidget {
  const PasswordAdderWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<PasswordAdderWidget> createState() => _PasswordAdderWidgetState();
}

class _PasswordAdderWidgetState extends State<PasswordAdderWidget> {
  InputFieldHandler password = InputFieldHandler(label: 'Password *');
  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
    widget.pageState.setState("password", password);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UnderlinedText(
                  heading: "Setup A Password",
                  fontSize: 30,
                  color: Color.fromARGB(255, 3, 43, 5),
                  underlineColor: Colors.green,
                  underlineWidth: 200,
                  underlineHeight: 5),
              const Text(
                  "Please set a password for your account, this will be used for authentication, if you forget this password you will not be able to access your account"),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 0,
                child: password.widget,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Password must be at least 8 characters long, and must contain at least one number and one special character",
                style: TextStyle(color: Colors.red.shade900),
              )
            ],
          ),
        ));
  }
}

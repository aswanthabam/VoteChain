import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import '../../widgets/paginated_views/paginated_views.dart' as paging;

class PasswordQueryPage extends FormPage<String> {
  @override
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? password = getState<InputFieldHandler>("password");
    if (password == null || password.text.isEmpty) {
      return FormPageStatus(false,
          "The password you entered is not valid, Please Enter a valid password");
    }
    validatedData = password.text;
    print(password.text);
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return PasswordQueryWidget(pageState: this);
  }
}

class PasswordQueryWidget extends StatefulWidget {
  const PasswordQueryWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<PasswordQueryWidget> createState() => _PasswordQueryWidgetState();
}

class _PasswordQueryWidgetState extends State<PasswordQueryWidget> {
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
                  heading: "Enter your password",
                  fontSize: 30,
                  color: Color.fromARGB(255, 3, 43, 5),
                  underlineColor: Colors.green,
                  underlineWidth: 200,
                  underlineHeight: 5),
              const Text(
                  "Please enter your password you created during registration"),
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
                "If you dont remember the password, you should visit the nearest election office to reset your password",
                style: TextStyle(color: Colors.red.shade900),
              )
            ],
          ),
        ));
  }
}

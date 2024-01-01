import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/input_components/keyboard.dart';
import 'package:vote/screens/widgets/input_components/valueDisplayer.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class PinAddPage extends FormPage<String> {
  @override
  // ignore: overridden_fields
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? password = getState<InputFieldHandler>("password");
    if (password == null ||
        password.text.isEmpty ||
        password.text.length != 6) {
      return FormPageStatus(false,
          "The PIN you entered is not valid, PIN must contain 6 characters");
    }
    validatedData = password.text;
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return PinAddWidget(pageState: this);
  }
}

class PinAddWidget extends StatefulWidget {
  const PinAddWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<PinAddWidget> createState() => _PinAddWidgetState();
}

class _PinAddWidgetState extends State<PinAddWidget> {
  late InputFieldHandler password;
  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
    password = InputFieldHandler(
      label: "PIN *",
      initialValue: Provider.of<VoterModal>(context, listen: false).pin,
      onChanged: (String val) {
        Provider.of<VoterModal>(context, listen: false).pin = val;
        widget.pageState.setState<InputFieldHandler>("password", password);
      },
      secureText: true,
    );
    widget.pageState.setState("password", password);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Icon(Icons.lock, size: 40, color: Colors.green),
                const SizedBox(
                  height: 20,
                ),
                const Text("Setup A PIN",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 10),
                const Text(
                  "Please set a PIN for your account, This pin will be used for locking your app",
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ValueDisplayer(
                    value: password.text,
                    length: 6,
                    fill: '-',
                    divide: const [1, 1, 1, 1, 1, 1]),
              ],
            ),
          ),
          const Spacer(),
          KeyBoard(onPressed: (String value) {
            setState(() {
              if (value == 'clr') {
                password.text = '';
              } else if (value == 'bck') {
                if (password.text.isNotEmpty) {
                  password.text =
                      password.text.substring(0, password.text.length - 1);
                }
              } else if (password.text.length < 6) {
                password.text += value;
              }
            });
          }),
        ],
      ),
    );
  }
}

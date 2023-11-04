import 'package:flutter/material.dart';
import 'valueDisplayer.dart';

class OTP extends StatefulWidget {
  OTP({super.key, required this.value, required this.onInputClick});
  String value;
  late void Function() onInputClick;
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String enteredValue = "";

  @override
  void initState() {
    super.initState();
    print("en: $enteredValue : " + widget.value);
    setState(() {
      enteredValue = widget.value;
    });
  }

  @override
  void didUpdateWidget(covariant OTP oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        enteredValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Enter OTP send to your mobile number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.12,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Enter 6 character OTP send to your number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.07,
              ),
            ),
          ),
          Center(
              child: GestureDetector(
            onTap: widget.onInputClick,
            child: ValueDisplayer(
                value: enteredValue,
                length: 6,
                divide: const <int>[3, 3],
                letterSpacing: 30,
                spacing: 0,
                fill: '_'),
          )),
          const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Trying to autocapture ",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 189, 189, 189)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color.fromARGB(136, 129, 199, 132),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}

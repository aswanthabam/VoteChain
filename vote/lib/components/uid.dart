import 'package:flutter/material.dart';
import '../components/valueDisplayer.dart';

class UID extends StatefulWidget {
  UID({super.key, required this.value});
  String value;
  @override
  State<UID> createState() => _UIDState();
}

class _UIDState extends State<UID> {
  String enteredValue = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      enteredValue = widget.value;
    });
  }

  @override
  void didUpdateWidget(covariant UID oldWidget) {
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
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Enter Your Unique Identification Number',
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
              'A code will be sent to your registered mobile number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.07,
              ),
            ),
          ),
          ValueDisplayer(
              value: enteredValue,
              length: 12,
              divide: const <int>[4, 4, 4],
              fill: '0'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  Password({super.key, required this.onChange});

  void Function(String val) onChange;
  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _controller = TextEditingController();
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
              'Set your Password',
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
              'Password must contain atleast 8 characters, atleast one Upper and lower case and one digit and special character',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.07,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  color: Color(0xff121212),
                ),
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
                obscureText: true,
                onChanged: widget.onChange,
              ))
        ],
      ),
    );
  }
}

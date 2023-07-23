import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, required this.function, required this.widget});
  Function function;
  Widget widget;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.function().then((val) => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => widget.widget))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // decoration: BoxDecoration(color: Colors.white),
        body: Column(children: [
      Image.asset('src/images/icon.png'),
      Text("VoteChain",
          style: TextStyle(
            fontSize: 20,
          ))
    ]));
  }
}

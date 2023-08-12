import 'package:flutter/material.dart';
import 'components/sidemenu.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
    theme: ThemeData(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Positioned(top: 0, left: 0, child: SideMenu())],
      ),
    );
  }
}

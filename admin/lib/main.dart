import 'package:flutter/material.dart';
import 'components/sidemenu.dart';
import 'pages/home.dart';
import 'pages/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    theme: ThemeData(),
    routes: {
      "home": (context) => MainApp(child: Home()),
      "splashscreen": (context) => SplashScreen()
    },
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0, left: 0, child: SideMenu()),
          Positioned(
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width - 200,
                child: child,
              ))
        ],
      ),
    );
  }
}

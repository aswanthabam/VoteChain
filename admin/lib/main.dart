import 'package:flutter/material.dart';
import 'components/sidemenu.dart';
import 'pages/home.dart';
import 'pages/splashscreen.dart';
import 'pages/admin.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    theme: ThemeData(),
    routes: {
      "home": (context) => MainApp(
            child: Home(),
            selected: "home",
          ),
      "splashscreen": (context) => SplashScreen(),
      "admin": (context) => MainApp(
            child: Admin(),
            selected: "admin",
          )
    },
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.child, required this.selected});
  Widget child;
  String selected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: SideMenu(
                selected: selected,
              )),
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vote/classes/preferences.dart';
import 'package:vote/pages/home.dart';
import 'package:vote/pages/admin.dart';
import 'package:vote/components/results.dart';
import 'package:vote/classes/contract_linker.dart';
import 'package:vote/pages/splashscreen.dart';
import 'pages/login.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // late ContractLinker linker;
  @override
  void initState() {
    super.initState();
    // init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vote Chain',
      initialRoute: 'login',
      routes: {
        'home': (context) => SplashScreen(
            function: () async {
              await Timer(Duration(seconds: 20), () => {});
            },
            widget: MyAppBar(body: Home())),
        'admin': (context) => MyAppBar(body: Admin()),
        'login': (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
    );
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({super.key, required this.body});

  Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'admin');
            },
            icon: Icon(Icons.settings),
            tooltip: "Settings (Admin)",
          )
        ],
        title: Text("Vote Chain"),
        backgroundColor: Colors.blue.shade300.withAlpha(180),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: this.body,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vote/pages/home.dart';
import 'package:vote/pages/admin.dart';
import 'package:vote/pages/splashscreen.dart';
import 'pages/getstarted.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/profile.dart';

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
      initialRoute: 'splashscreen',
      routes: {
        'home': (context) => const Home(),
        'admin': (context) => const Admin(),
        'getstarted': (context) => const GetStarted(),
        'splashscreen': (context) => const SplashScreen(),
        'login': (context) => const Login(),
        'register': (context) => const Register(),
        'profile': (context) => const Profile(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
    );
  }
}

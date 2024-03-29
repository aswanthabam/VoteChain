import 'package:flutter/material.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/elections/elections.dart';
import 'package:vote/screens/pages/home/home.dart';
import 'package:vote/screens/pages/admin/admin.dart';
import 'package:vote/screens/pages/settings/settings.dart';
import 'package:vote/screens/pages/splashscreen/splashscreen.dart';
import 'package:vote/screens/pages/testscreen/test.dart';
import 'screens/pages/getstarted/getstarted.dart';
import 'screens/pages/login/login.dart';
import 'screens/pages/register/register.dart';
import 'screens/pages/profile/profile.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => VoterModal())],
        child: MaterialApp(
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
            'settings': (context) => const Settings(),
            'elections': (context) => const Elections(),
            'test': (context) => const TestWidget(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
        ));
  }
}

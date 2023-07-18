import 'package:flutter/material.dart';
import 'package:vote/classes/preferences.dart';
import 'package:vote/pages/home.dart';
import 'package:vote/pages/admin.dart';
import 'package:vote/components/results.dart';
import 'package:vote/classes/contract_linker.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ContractLinker linker;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // await Preferences.init();
    linker = ContractLinker();
    linker.init(cond: Preferences.init());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vote Chain',
      initialRoute: 'home',
      routes: {
        'home': (context) => MyAppBar(body: Home(linker: linker)),
        'admin': (context) => MyAppBar(body: Admin()),
      },
      home: MyAppBar(
        body: Home(
          linker: linker,
        ),
      ),
      debugShowCheckedModeBanner: false,
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

import 'package:flutter/material.dart';
import 'package:vote/home.dart';
import 'package:vote/results.dart';
import 'package:vote/contract_linker.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ContractLinker linker = ContractLinker();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    linker.initWeb3();
    await linker.loadContracts();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vote Chain',
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
        title: Text("Vote Chain"),
        backgroundColor: Colors.grey.shade500.withAlpha(180),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 0, 113, 77),
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
      body: this.body,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vote/classes/preferences.dart';
import '../components/appbars/appbar.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController rpcUrl =
      TextEditingController(text: "http://192.168.18.2:7545");
  TextEditingController helperUrl =
      TextEditingController(text: "http://192.168.18.2:3131");
  TextEditingController contractAddress =
      TextEditingController(text: "0x6ea72486a146e2b3cd3d1d5908b3107eb72f4991");
  TextEditingController wsUrl =
      TextEditingController(text: "ws://192.168.18.2:7545");

  @override
  void initState() {
    super.initState();
    rpcUrl.text = Preferences.rpcUrl;
    helperUrl.text = Preferences.helperUrl;
    contractAddress.text = Preferences.contractAddress ?? "";
    wsUrl.text = Preferences.wsUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: "RPC Url",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                controller: rpcUrl,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: "WebSocket Url",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                controller: wsUrl,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: "Helper Server Url",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                controller: helperUrl,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: "Contract Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                controller: contractAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Preferences.reset().then((value) {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return Text(
                                    value ? "Reseted" : "Error Reseting");
                              });
                        });
                      },
                      child: const Text("Reset")),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Preferences.setRpcUrl(rpcUrl.text);
                        Preferences.setHelperUrl(helperUrl.text);
                        Preferences.setConractAddress(contractAddress.text);
                        Preferences.setWsUrl(wsUrl.text);
                        print("Saved");
                      },
                      child: const Text("Save"))
                ],
              )
            ],
          ),
        ));
  }
}

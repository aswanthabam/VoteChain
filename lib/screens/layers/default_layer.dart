import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/appbar.dart';

class DefaultLayer extends StatefulWidget {
  const DefaultLayer({super.key, required this.child});
  final Widget child;
  @override
  State<DefaultLayer> createState() => _DefaultLayerState();
}

class _DefaultLayerState extends State<DefaultLayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          height: AppBar().preferredSize.height,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.green.shade50,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'elections');
                  },
                  icon: const Icon(
                    Icons.list_rounded,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'profile');
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'settings');
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 25,
                  ),
                ),
              ],
            )),
        body: widget.child);
  }
}

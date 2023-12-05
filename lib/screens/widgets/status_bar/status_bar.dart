import 'package:flutter/material.dart';

class StatusBar extends StatefulWidget {
  const StatusBar(
      {super.key,
      required this.padding,
      required this.fractions,
      required this.current});
  final double padding;
  final int fractions;
  final int current;
  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: widget.padding, right: widget.padding, top: 20, bottom: 20),
        child: Flexible(
          child: FractionallySizedBox(
              widthFactor: 1,
              child: Stack(
                children: [
                  Positioned(
                    child: FractionallySizedBox(
                        widthFactor: widget.current / widget.fractions,
                        child: Container(
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                                color: const Color(0xff1ba68d),
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                  Positioned(
                      child: Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(128, 27, 166, 141),
                        borderRadius: BorderRadius.circular(10)),
                  ))
                ],
              )),
        ));
  }
}

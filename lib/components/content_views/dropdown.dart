import 'package:flutter/material.dart';

abstract class ContentType {
  Widget build();
}

class TextContent extends ContentType {
  TextContent({required this.content});

  String content;

  @override
  Widget build() {
    return Text(content);
  }
}

class ContentDropdown extends StatefulWidget {
  ContentDropdown({super.key, required this.heading, required this.contents});
  String heading;
  List<ContentType> contents;
  @override
  State<ContentDropdown> createState() => _ContentDropdownState();
}

class _ContentDropdownState extends State<ContentDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 10,
                          color: Colors.grey.shade200)
                    ],
                    color: Color.fromARGB(255, 235, 248, 235),
                    borderRadius: BorderRadius.circular(20)),
                child: GestureDetector(
                    onTap: () {
                      print("Tapped");
                    },
                    child: Row(children: [
                      Text(
                        widget.heading,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 35,
                        color: Colors.grey,
                      )
                    ]))))
      ],
    );
  }
}

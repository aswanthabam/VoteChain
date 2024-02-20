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

class ListContent extends ContentType {
  ListContent({required this.list});
  List<String> list;
  @override
  Widget build() {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list
            .map<Widget>((e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      " * $e",
                      softWrap: true,
                    )
                  ],
                ))
            .toList(),
      )
    ]);
  }
}

class ContentDropdown extends StatefulWidget {
  const ContentDropdown(
      {super.key,
      required this.heading,
      required this.contents,
      required this.height});
  final String heading;
  final List<ContentType> contents;
  final double height;
  @override
  State<ContentDropdown> createState() => _ContentDropdownState();
}

class _ContentDropdownState extends State<ContentDropdown> {
  bool expanded = false;
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
                    color: const Color.fromARGB(255, 235, 248, 235),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          expanded = !expanded;
                        });
                        print("Tapped");
                      },
                      child: Row(children: [
                        Text(
                          widget.heading,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 35,
                          color: Colors.grey,
                        )
                      ])),
                  const SizedBox(
                    height: 10,
                  ),
                  (expanded
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          height: widget.height,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 213, 245, 215),
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.contents
                                .map<Widget>((e) => Row(children: [
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            e.build(),
                                            const SizedBox(
                                              height: 10,
                                            )
                                          ]))
                                    ]))
                                .toList(),
                          )))
                      : const SizedBox(
                          height: 0,
                        ))
                ])))
      ],
    );
  }
}

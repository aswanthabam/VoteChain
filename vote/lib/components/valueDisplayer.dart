import 'dart:ffi';

import 'package:flutter/material.dart';

class ValueDisplayer extends StatefulWidget {
  ValueDisplayer(
      {super.key,
      required this.value,
      required this.length,
      required this.divide,
      this.spacing = 10,
      this.fill = '0',
      this.fontSize = 30,
      this.letterSpacing = 3,
      this.fontWeight = FontWeight.w500});

  double fontSize, letterSpacing, spacing;
  FontWeight fontWeight;
  int length;
  List<int> divide;
  String value = "", fill = "0";
  @override
  State<ValueDisplayer> createState() => _ValueDisplayerState();
}

class _ValueDisplayerState extends State<ValueDisplayer> {
  List<List<Map<String, bool>>> value = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Val : " + parseValue(widget.value));
    addFormated(parseValue(widget.value));
  }

  @override
  void didUpdateWidget(covariant ValueDisplayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      addFormated(parseValue(widget.value));
    }
  }

  String parseValue(String val) {
    String res = "";
    for (var i = 0; i < widget.length; i++) {
      if (i < val.length) {
        res += val.characters.elementAt(i);
      } else {
        res += widget.fill;
      }
    }
    return res;
  }

  void addFormated(String val) {
    setState(() {
      value = [];
      int k = 0;
      for (var i = 0; i < widget.divide.length; i++) {
        List<Map<String, bool>> tmp = [];
        for (var j = 0; j < widget.divide[i]; j++) {
          bool ktmp = false;
          if (k < widget.value.length) ktmp = true;
          if (k < widget.length) {
            tmp.add(<String, bool>{val.characters.elementAt(k): ktmp});
            k++;
          } else {
            tmp.add(<String, bool>{widget.fill: ktmp});
          }
        }
        value.add(tmp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 65,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: value.map((e) {
              return Row(children: [
                Row(
                  children: e.map((e) {
                    return Text(
                      e.keys.first,
                      style: TextStyle(
                        color: e.values.first
                            ? Colors.black
                            : const Color(0xBC7D7777),
                        fontSize: widget.fontSize,
                        fontFamily: 'RobotoMono',
                        fontWeight: widget.fontWeight,
                        letterSpacing: widget.letterSpacing,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: widget.spacing)
              ]);
            }).toList()));
  }
}

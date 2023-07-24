import 'package:flutter/material.dart';

class KeyBoard extends StatefulWidget {
  KeyBoard(
      {super.key, required this.onPressed, this.width = 100, this.length = -1});
  late Function(String) onPressed;
  double width = 100;
  int length;
  @override
  State<KeyBoard> createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  int charCount = 0;
  void valueClicked(String val) {
    print("Char Count : $charCount");
    if (widget.length == -1)
      widget.onPressed(val);
    else {
      if (val == "clr") {
        charCount = 0;
        widget.onPressed(val);
      } else if (val == "bck") {
        if (charCount > 0) {
          charCount--;
          widget.onPressed(val);
        }
      } else {
        if (charCount < widget.length) {
          widget.onPressed(val);
          charCount++;
        }
      }
    }
    print("Char Count After : $charCount");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: ShapeDecoration(
            color: Color(0xFFE0FFF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x542A7164),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('1');
                        },
                        child: Center(
                            child: Text(
                          "1",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('2');
                        },
                        child: Center(
                            child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('3');
                        },
                        child: Center(
                            child: Text(
                          "3",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('4');
                        },
                        child: Center(
                            child: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('5');
                        },
                        child: Center(
                            child: Text(
                          "5",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('6');
                        },
                        child: Center(
                            child: Text(
                          "6",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('7');
                        },
                        child: Center(
                            child: Text(
                          "7",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('8');
                        },
                        child: Center(
                            child: Text(
                          "8",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('9');
                        },
                        child: Center(
                            child: Text(
                          "9",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('clr');
                        },
                        child: Center(
                            child: Icon(
                          Icons.clear_outlined,
                          color: Colors.black,
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('0');
                        },
                        child: Center(
                            child: Text(
                          "0",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                          ),
                        ))),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          valueClicked('bck');
                        },
                        child: Center(
                            child: Icon(
                          Icons.backspace_outlined,
                          color: Colors.black,
                        ))),
                  ),
                ],
              ),
              SizedBox(height: 15)
            ],
          ),
        ));
  }
}

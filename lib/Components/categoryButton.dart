import 'dart:math';

import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final String text;
  final bool enabled;
  final VoidCallback func;

  CategoryButton({this.text, @required this.enabled, this.func});

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool en;

  Color colorPicker(String s) {
    int c = s[0].codeUnitAt(0) - 64;
    int r = (256 * c / 5).toInt();
    int g = (256 * c / 4).toInt();
    int b = (256 * c / 6).toInt();

    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    en = !widget.enabled;
    if (widget.text != null) print(widget.text[0].codeUnitAt(0));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ElevatedButton(
        onPressed: () {
          if (widget.enabled) {
            en = !en;
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => en ? colorPicker(widget.text) : Colors.grey[600])),
        child: Text(
          widget.text ?? "Category",
        ),
      ),
    );
  }
}

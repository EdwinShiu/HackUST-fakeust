import 'dart:math';

import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback func;

  CategoryButton({this.text, @required this.enabled, this.func});

  bool en;

  @override
  Widget build(BuildContext context) {
    en = !enabled;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ElevatedButton(
        onPressed: () {
          if (enabled) {
            en = !en;
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith((states) => en
                ? Color((Random().nextDouble() * 0x8FFFFF).toInt())
                    .withOpacity(0.5)
                : Colors.grey[600])),
        child: Text(
          text ?? "Category",
        ),
      ),
    );
  }
}

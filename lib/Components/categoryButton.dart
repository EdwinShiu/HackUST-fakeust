import 'dart:math';

import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ElevatedButton(
        onPressed: () => print("Pressed"),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith((states) =>
                Color((Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(0.5))),
        child: Text(
          "Category",
        ),
      ),
    );
  }
}

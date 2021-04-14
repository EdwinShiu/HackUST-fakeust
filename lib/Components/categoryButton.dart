import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Constants/constants.dart';

typedef CallbackAction(String s);

class CategoryButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final CallbackAction func;

  CategoryButton({this.text, @required this.enabled, this.func});

  @override
  Widget build(BuildContext context) {
    bool en = !enabled;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ElevatedButton(
        onPressed: () {
          if (enabled) {
            func(text);
            en = !en;
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => en ? Color(tagColor[text]) : Colors.grey[600])),
        child: Text(
          text ?? "Category",
        ),
      ),
    );
  }
}

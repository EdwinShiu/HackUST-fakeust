import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Constants/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    en = !widget.enabled;
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
                (states) => en ? Colors.red : Colors.grey[600])),
        child: Text(
          widget.text ?? "Category",
        ),
      ),
    );
  }
}

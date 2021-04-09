import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int minLines;
  final int maxLines;
  final TextStyle style;

  const ExpandableText(
      {Key key, this.minLines = 5, this.maxLines, this.text, this.style})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Text(
        widget.text,
        overflow: TextOverflow.ellipsis,
        maxLines: _isExpanded ? widget.maxLines : widget.minLines,
        style: widget.style,
      ),
    );
  }
}

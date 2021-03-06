import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SiteDescriptionDialog extends StatelessWidget {
  final String site;
  final String description;

  SiteDescriptionDialog({this.site, this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AutoSizeText(
              site ?? "Site",
              style: TextStyle(fontSize: 40.0, color: Colors.black),
              maxLines: 1,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  description ?? "description",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

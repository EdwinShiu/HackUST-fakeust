import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error', style: Theme.of(context).textTheme.bodyText1),
    );
  }
}

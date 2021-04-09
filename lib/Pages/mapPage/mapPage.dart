import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/mapWidget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MapWidget(),
      ),
    );
  }
}

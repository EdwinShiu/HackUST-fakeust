import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RedeemPage extends StatelessWidget {
  RedeemPage({Key key, this.setPage}) : super(key: key);

  final ValueSetter<int> setPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Redeem",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.06,
                  child: TextButton(
                    onPressed: () {
                      setPage(0);
                    },
                    child: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Color(0xFF1e1e1e),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

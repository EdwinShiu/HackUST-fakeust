import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackust_fakeust/Components/categoryButton.dart';
import 'package:hackust_fakeust/Pages/SitePage/sitePage.dart';

class AddTagDialog extends StatefulWidget {
  final List<dynamic> list;
  final String site;
  final State<SitePage> parent;
  AddTagDialog({this.list, this.site, this.parent});

  @override
  _AddTagDialogState createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  List<String> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('tags').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Text("No Tags");
            else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Suggest Tag",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      for (var tag in snapshot.data.docs)
                        if (widget.list == null ||
                            !widget.list.contains(tag["tag"]))
                          CategoryButton(
                            text: tag["tag"],
                            enabled: true,
                            func: (String s) => suggestions.add(s),
                          ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<StadiumBorder>(
                            StadiumBorder()),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blue)),
                    child: Text(
                      "Submit",
                    ),
                    onPressed: () async {
                      print(suggestions);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Text(
                                  "Thanks for your suggestion",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          });
                      String docId = await FirebaseFirestore.instance
                          .collection("regions")
                          .where("region_name", isEqualTo: widget.site)
                          .get()
                          .then((value) => value.docs[0]['rid']);
                      FirebaseFirestore.instance
                          .collection("regions")
                          .doc(docId)
                          .update({"tags": FieldValue.arrayUnion(suggestions)});

                      suggestions.clear();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        widget.parent.setState(() {});
                      });
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

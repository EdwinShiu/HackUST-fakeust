import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackust_fakeust/Components/categoryButton.dart';

class AddTagDialog extends StatefulWidget {
  final List<dynamic> list;
  AddTagDialog({this.list});

  @override
  _AddTagDialogState createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  List<String> suggestions = [];

  void addSuggestions(String s) {
    suggestions.add(s);
  }

  @override
  void dispose() {
    super.dispose();
    print(suggestions);
  }

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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      for (var tag in snapshot.data.docs)
                        if (!widget.list.contains(tag["tag"]))
                          CategoryButton(
                            text: tag["tag"],
                            enabled: true,
                            func: (String s) => addSuggestions(s),
                          ),
                    ],
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

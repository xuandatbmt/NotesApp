import 'package:flutter/material.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/models/category_model.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/models/priority_model.dart';
import 'package:notes/models/status_model.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/text_field.dart';
import 'package:http/http.dart' as http;

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

List<Category> categoryList;
List<Priority> priorityList;
List<Status> statusList;
List<Notes> notes;

class _AddNoteScreenState extends State<AddNoteScreen> {
  String _title;
  String _content;
  DateTime _dateTime;
  @override
  void initState() {
    super.initState();
    fetchList();
  }

  void fetchList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
                title: 'Add Note',
                icon: FontAwesomeIcons.solidSave,
                onPressed: () async {
                  Map<String, dynamic> params = Map<String, dynamic>();
                  params["title"] = _title.toString();
                  params["body"] = _content.toString();
                  params["created_at"] = DateTime.now();
                  params["expires_at"] = _dateTime.toString();
                  // params["priority"] =  this.prioritySelect.toString();
                  // params["status"] = this.statusSelect.toString();
                  //  params["category"] = this.categorySelect.toString();
                  await data.addNote(http.Client(), params);
                  Navigator.pop(context);
                }),
            AddingTextField(
                maxLines: 1,
                hintText: 'Title',
                onChanged: (value) {
                  _title = value;
                }),
            Flexible(
                child: AddingTextField(
                    maxLines: 50,
                    hintText: 'Note',
                    onChanged: (value) {
                      _content = value;
                    })),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.category),
                      onPressed: () {
                        showCategories(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2030),
                        ).then((date) => _dateTime = date);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.playlist_add_check),
                      color: mainAccentColor,
                      onPressed: () {
                        showStatus(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.label_outline),
                      color: mainAccentColor,
                      onPressed: () {
                        showPrioty(context);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showCategories(context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Select a Category',
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                categoryList.length,
                (index) {
                  return SimpleDialogOption(
                    child: ListTile(
                      title: Text(categoryList[index].categoryName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      setState(() {
                        // this.categorySelect = categoryList[index].categoryName;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPrioty(context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Select a Prioty',
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: List.generate(
              //   categoryList.length,
              //   (index) {
              //     return SimpleDialogOption(
              //       child: ListTile(
              //         leading: Icon(
              //           Icons.label_outline,
              //           color: categoryList[index].color,
              //         ),
              //         title: Text(categoryList[index].name,
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold)),
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           note.category.name = categoryList[index].name;
              //           note.category.color = categoryList[index].color;
              //         });
              //         Navigator.pop(context);
              //       },
              //     );
              //   },
              // ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showStatus(context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Select a Status',
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: List.generate(
              //   categoryList.length,
              //   (index) {
              //     return SimpleDialogOption(
              //       child: ListTile(
              //         leading: Icon(
              //           Icons.label_outline,
              //           color: categoryList[index].color,
              //         ),
              //         title: Text(categoryList[index].name,
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold)),
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           note.category.name = categoryList[index].name;
              //           note.category.color = categoryList[index].color;
              //         });
              //         Navigator.pop(context);
              //       },
              //     );
              //   },
              // ),
            ),
          ],
        );
      },
    );
  }
}

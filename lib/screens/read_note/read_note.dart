import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/screens/add_note/add_note.dart';
import 'package:notes/screens/add_note/components/text_field.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditNoteScreen extends StatefulWidget {
  final String id;
  EditNoteScreen({this.id}) : super();
  @override
  State<StatefulWidget> createState() {
    return _EditNoteScreenState();
  }
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
        body: FutureBuilder(
            future: data.fetchNoteId(http.Client(), widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return EditNote(notes: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class EditNote extends StatefulWidget {
  final Notes notes;
  final String id;
  EditNote({Key key, this.notes, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditNoteState();
  }
}

class _EditNoteState extends State<EditNote> {
  Notes notes;
  bool isLoadNote = false;
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    if (isLoadNote == false) {
      setState(() {
        this.notes = Notes.fromNote(widget.notes);
        this.isLoadNote = true;
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Edit Note',
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();

                params["id"] = this.notes.id;
                params["title"] = this.notes.title.toString();
                params["body"] = this.notes.body.toString();
                // params["title"] = this.notes[index].title.toString();
                if (notes.title != '' && notes.body != '') {
                  await data.updateNote(http.Client(), params);
                  Navigator.pop(context);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                decoration: InputDecoration(hintText: "Title"),
                controller: TextEditingController(text: this.notes.title),
                onChanged: (text) {
                  setState(() {
                    this.notes.title = text;
                  });
                },
              ),
            ),
            //AddingTextField(maxLines: 1, hintText: 'Title'),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  maxLines: 50,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: "Content"),
                  controller: TextEditingController(text: this.notes.body),
                  onChanged: (text) {
                    setState(() {
                      this.notes.body = text;
                    });
                  },
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         IconButton(
            //           icon: Icon(Icons.category),
            //           onPressed: () {
            //             showCategories(context);
            //           },
            //         ),
            //         IconButton(
            //           icon: Icon(
            //             Icons.calendar_today,
            //           ),
            //           onPressed: () {
            //             showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(1970),
            //               lastDate: DateTime(2030),
            //             ).then((date) => _dateTime = date);
            //           },
            //         ),
            //         IconButton(
            //           icon: Icon(Icons.playlist_add_check),
            //           color: mainAccentColor,
            //           onPressed: () {
            //             showStatus(context);
            //           },
            //         ),
            //         IconButton(
            //           icon: Icon(Icons.label_outline),
            //           color: mainAccentColor,
            //           onPressed: () {
            //             showPrioty(context);
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/screens/add_note/components/text_field.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'components/text_field.dart';
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
        appBar: AppBar(
          title: Text("Edit Note"),
        ),
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

  const EditNote({Key key, this.notes}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditNoteState();
  }
}

class _EditNoteState extends State<EditNote> {
  Notes notes = new Notes();
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Edit Note',
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params["id"] = this.notes.id.toString();
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
                decoration: InputDecoration(hintText: "Cc"),
                controller: TextEditingController(text: this.notes.title),
              ),
            ),
            //AddingTextField(maxLines: 1, hintText: 'Title'),
            Flexible(
              child: TextField(
                maxLines: 50,
                decoration: InputDecoration(hintText: "Cc"),
                controller: TextEditingController(text: this.notes.body),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

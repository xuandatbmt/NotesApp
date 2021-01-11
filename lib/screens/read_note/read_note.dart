import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes/localization/localization_constants.dart';
import 'package:notes/models/category_model.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/models/priority_model.dart';
import 'package:notes/models/status_model.dart';
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
  // TextEditingController titleEditingController = TextEditingController();
  // TextEditingController textEditingController = TextEditingController();
  // @override
  // void dispose() {
  //   textEditingController.dispose();
  //   titleEditingController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    // titleEditingController.text = note.title;
    // textEditingController.text = note.text;
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

class TextController extends TextEditingController {
  TextController({String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}

class _EditNoteState extends State<EditNote> {
  Notes notes;
  bool isLoadNote = false;
  DateTime _dateTime;
  List<Category> categoryList;
  List<Priority> priorityList;
  List<Status> statusList;
  String _categorySelected;
  String _prioritySelected;
  String _statusSelected;
  var _dateofTime;
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
              title: getTranslated(context, 'edit_note_screen'),
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();

                params["id"] = this.notes.id;
                params["title"] = this.notes.title.toString();
                params["body"] = this.notes.body.toString();
                params["expires_at"] = _dateofTime.toString();
                params["priority"] = _prioritySelected.toString();
                params["status"] = _statusSelected.toString();
                params["update_at"] = DateTime.now().toString();
                params["category"] = _categorySelected.toString();
                if (notes.title != '' && notes.body != '') {
                  await data.updateNote(http.Client(), params);
                  Navigator.pop(context);
                  data.update();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: getTranslated(context, 'hint_title')),
                controller: TextController(
                  text: this.notes.title,
                ),
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
                  decoration: InputDecoration(
                      hintText: getTranslated(context, 'hint_text_1')),
                  controller: TextController(text: this.notes.body),
                  onChanged: (text) {
                    setState(() {
                      this.notes.body = text;
                    });
                  },
                ),
              ),
            ),
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
                        _showCategories(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                      onPressed: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(Duration(seconds: 1)),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2030),
                        ).then((date) => _dateTime = date);
                        final _time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: DateTime.now().hour,
                              minute: DateTime.now().minute),
                        );
                        _dateofTime = _time.format(context) +
                            " " +
                            DateFormat("dd/MM/yyyy").format(_dateTime);
                        print(_dateofTime);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.playlist_add_check),
                      onPressed: () {
                        _showStatus(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.label_outline),
                      onPressed: () {
                        _showPriority(context);
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

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0,
      width: 300.0,
      child: FutureBuilder(
          future: Provider.of<Data>(context).fetchCategory(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].categoryName,
                          style: TextStyle(
                              //color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        this._categorySelected =
                            snapshot.data[index].categoryName;
                        Navigator.pop(context);

                        print(_categorySelected);
                      },
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _showCategories(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, 'selected_category')),
            content: setupAlertDialoadContainer(),
          );
        },
      );
  Widget containPriority() {
    return Container(
      height: 300.0,
      width: 300.0,
      child: FutureBuilder(
          future: Provider.of<Data>(context).fetchPriority(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].priorityName,
                          style: TextStyle(
                              //color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        this._prioritySelected =
                            snapshot.data[index].priorityName;
                        Navigator.pop(context);
                        print(_prioritySelected);
                      },
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _showPriority(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, 'selected_priority')),
            content: containPriority(),
          );
        },
      );
  Widget contaninerStatus() {
    return Container(
      height: 300.0,
      width: 300.0,
      child: FutureBuilder(
          future: Provider.of<Data>(context).fetchStatus(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].statusName,
                          style: TextStyle(
                              //color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        this._statusSelected = snapshot.data[index].statusName;
                        Navigator.pop(context);
                        print(_statusSelected);
                      },
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _showStatus(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, 'selected_status')),
            content: contaninerStatus(),
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/localization/localization_constants.dart';
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

class _AddNoteScreenState extends State<AddNoteScreen> {
  String _title;
  String _content;
  DateTime _dateTime;
  List<Category> categoryList;
  List<Priority> priorityList;
  List<Status> statusList;
  List<Notes> notes;
  String _categorySelected;
  String _prioritySelected;
  String _statusSelected;
  var _dateofTime;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
                title: getTranslated(context, 'add_note'),
                icon: FontAwesomeIcons.solidSave,
                onPressed: () async {
                  Map<String, dynamic> params = Map<String, dynamic>();
                  params["title"] = _title.toString();
                  params["body"] = _content.toString();
                  params["expires_at"] = _dateofTime.toString();
                  params["priority"] = _prioritySelected.toString();
                  params["status"] = _statusSelected.toString();
                  params["category"] = _categorySelected.toString();
                  if (_title != '' &&
                      _content != '' &&
                      _categorySelected != '' &&
                      _statusSelected != '' &&
                      _prioritySelected != '' &&
                      _dateofTime != '') {
                    await data.addNote(http.Client(), params);
                    Navigator.pop(context);
                    data.update();
                  } else {
                    return AlertDialog(
                      title: Text(getTranslated(context, 'wrong')),
                      content: Text(getTranslated(context, 'missing_data')),
                      actions: <Widget>[
                        myFlatButton('OK', Colors.grey, false),
                      ],
                      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 5),
                      insetPadding: EdgeInsets.symmetric(horizontal: 20),
                    );
                  }
                }),
            AddingTextField(
                maxLines: 1,
                hintText: getTranslated(context, 'hint_title'),
                onChanged: (value) {
                  _title = value;
                }),
            Flexible(
                child: AddingTextField(
                    maxLines: 50,
                    hintText: getTranslated(context, 'hint_text'),
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
                      color: mainAccentColor,
                      onPressed: () {
                        _showStatus(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.label_outline),
                      color: mainAccentColor,
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
                              // color: Colors.black,
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
                              // color: Colors.black,
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
                              // color: Colors.black,
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
  Widget myFlatButton(title, color, value) {
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
      onPressed: () => Navigator.of(context).pop(value),
    );
  }
}

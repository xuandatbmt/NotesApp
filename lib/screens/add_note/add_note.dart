import 'package:flutter/material.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/models/category_model.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/models/priority_model.dart';
import 'package:notes/models/status_model.dart';
import 'package:notes/screens/home/components/list_view.dart';
import 'package:notes/screens/home/home.dart';
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

Data _data;

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
  @override
  void initState() {
    //  this.fetchList();
    super.initState();
  }

  // fetchList() async {
  //   this.categoryList = _data.fetchCategory(http.Client());
  //   this.priorityList = _data.fetchPriority(http.Client());
  //   this.statusList = _data.fetchStatus(http.Client());
  // }

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
                  //params["created_at"] = DateTime.now();
                  params["expires_at"] = _dateTime.toString();
                  params["priority"] = _prioritySelected.toString();
                  params["status"] = _statusSelected.toString();
                  params["category"] = _categorySelected.toString();
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
                        _showCategories(context);
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
                        print(_dateTime);
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
                              color: Colors.black,
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
            title: Text('Selected Category'),
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
                              color: Colors.black,
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
            title: Text('Selected Priority'),
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
                              color: Colors.black,
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
            title: Text('Selected Status'),
            content: contaninerStatus(),
          );
        },
      );
}

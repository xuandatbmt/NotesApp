import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notes/screens/add_category/add_category.dart';
import 'package:notes/screens/add_note/add_note.dart';
import 'package:notes/screens/add_prioty/add_prioty.dart';
import 'package:notes/screens/home/components/list_view.dart';
import 'package:notes/services/data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PriotyScreen extends StatefulWidget {
  @override
  _PriotyScreenState createState() => _PriotyScreenState();
}

class _PriotyScreenState extends State<PriotyScreen> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        title: Text(
          "List Category",
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: data.fetchNotes(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return CustomListView(notes: snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        // backgroundColor: Colors.redAccent,
        children: [
          SpeedDialChild(
            child: Icon(Icons.event),
            label: "Add Note",
            backgroundColor: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNoteScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.create_new_folder),
            label: "Add Category",
            backgroundColor: Colors.green,
            onTap: () {
              // newCategory = Category('Not Specified');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCategorycreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.create_sharp),
            label: "Add Prioty",
            backgroundColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPriotycreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

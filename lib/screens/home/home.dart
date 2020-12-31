import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/screens/add_category/add_category.dart';
import 'package:notes/screens/add_note/add_note.dart';
import 'package:notes/screens/add_prioty/add_prioty.dart';
import 'package:notes/screens/menu/draw_menu.dart';
import 'components/list_view.dart';
import 'components/appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var _scaffoldKey = new GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: OptionMenu(),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white10,
              elevation: 0.0,
              title: Text(
                "Notes Manager",
                 textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black),
              ),
              leading: FlatButton(
                  onPressed: () {
                    print("click menu");
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(Icons.menu)),
            ),
            // name
            CustomListView(),
          ],
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

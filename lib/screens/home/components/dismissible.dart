import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/screens/read_note/read_note.dart';
import 'package:notes/services/data.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_alert_dialog.dart';
import 'package:http/http.dart' as http;

class CustomDismissible extends StatelessWidget {
  final List<Notes> notes;
  final int index;
  const CustomDismissible({Key key, this.notes, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();

    return Dismissible(
      key: ValueKey(notes[index].title),
      direction: DismissDirection.endToStart,
      child: Card(
        child: ListTile(
          title: Text(
            notes[index].title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              notes[index].body,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.all(2),
            child: Column(children: <Widget>[
              Text(
                notes[index].createdAt,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff959EA7),
                ),
              ),
              SizedBox(height: 5),
              Text(
                notes[index].status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff959EA7),
                ),
              ),
              SizedBox(height: 5),
              Text(
                notes[index].category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff959EA7),
                ),
              ),
            ]),
          ),
          onTap: () {
            String selectedId = notes[index].id;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditNoteScreen(id: selectedId)));
          },
          contentPadding: EdgeInsets.all(17),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      background: Padding(
        padding: EdgeInsets.only(right: 30),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(FontAwesomeIcons.trashAlt,
              color: Color(0xFFFA8182), size: 28),
        ),
      ),
      onDismissed: (direction) async {
        await data.deleteNote(http.Client(), this.notes[index].id);
      },
      confirmDismiss: (direction) => showDialog(
          context: context, builder: (context) => CustomAlertDialog()),
    );
  }
}

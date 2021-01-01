// import 'package:flutter/material.dart';
// import 'package:notes/models/notes_model.dart';
// import 'package:notes/screens/read_note/read_note.dart';
// import 'package:notes/services/data.dart';
// import 'package:provider/provider.dart';

// // class NotesList extends StatelessWidget {
// //   final List<Notes> notes;
// //   NotesList({Key key, this.notes}):super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //       return ListView.builder(itemBuilder: (context, index ){

// //       });
// //   }
// // }

// class CustomListTile extends StatelessWidget {
//   //List<Notes> notes;
//   final int index;
//   const CustomListTile({Key key, this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//   //  var data = context.watch<Data>();

//     return ListTile(
//       title: Text(
//         notes[index].title,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: Text(
//           notes[index].body,
//           overflow: TextOverflow.ellipsis,
//           maxLines: 1,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
//         ),
//       ),
//       trailing: Text(
//         notes[index].createdAt,
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w400,
//           color: Color(0xff959EA7),
//         ),
//       ),
//       onTap: () => Navigator.push(context,
//           MaterialPageRoute(builder: (context) => ReadNoteScreen(index))),
//       contentPadding: EdgeInsets.all(17),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     );
//   }
// }

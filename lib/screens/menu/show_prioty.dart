import 'package:flutter/material.dart';
import 'package:notes/screens/menu/components/listview_p.dart';

import 'package:notes/services/data.dart';
import 'package:notes/themes/colors.dart';
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
          "List Priority",
          textAlign: TextAlign.right,
          style: TextStyle(color: textColor),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: data.fetchPriority(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return CustomListView(priority: snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

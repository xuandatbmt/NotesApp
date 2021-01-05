import 'package:flutter/material.dart';
import 'package:notes/services/data.dart';
import 'package:notes/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'components/list_view_s.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        title: Text(
          "List Status",
          textAlign: TextAlign.right,
          style: TextStyle(color: fabSplashColor),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: data.fetchStatus(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return CustomListView(status: snapshot.data);
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

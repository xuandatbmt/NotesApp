import 'package:flutter/material.dart';
import 'package:notes/services/data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'components/list_view_c.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
          future: data.fetchCategory(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return CustomListView(category: snapshot.data);
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

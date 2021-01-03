import 'package:flutter/material.dart';
import 'package:notes/models/notes_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:notes/services/data.dart';
import 'package:http/http.dart' as http;

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    Key key,
  }) : super(key: key);
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<charts.Series<Notes, String>> _seriesBarData;
  List<Notes> mydata;

  _generateData(mydata) {
    _seriesBarData.add(charts.Series(
        domainFn: (Notes note, _) => note.body.toString(),
        measureFn: (Notes note, _) => note.id.length,
        colorFn: (Notes note, _) =>
            charts.ColorUtil.fromDartColor(Colors.black),
        id: 'Notes',
        data: mydata,
        labelAccessorFn: (Notes row, _) => "${row.id}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        title: Text(
          "Statistics",
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    var data = context.watch<Data>();
    return FutureBuilder(
      future: data.fetchNotes(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return _buildBody(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Notes> notes) {
    mydata = notes;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Status for Notes",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 3),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

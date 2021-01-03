import 'dart:convert';
import 'package:provider/provider.dart';
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

class Chart {
  final String name;
  final int value;
  Chart(this.name, this.value);
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<charts.Series<Chart, String>> _seriesBarData;
  List<Chart> mydata;
  //  _getData() async{
  //   final response = await http.get('https://api-mobile-app.herokuapp.com/api/count', headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': '$token',
  //   });
  //   Map<String,dynamic> map = json.decode(response.body);
  //   return map;
  // }
  _generateData(mydata) {
    _seriesBarData.add(charts.Series(
        domainFn: (Chart chart, _) => chart.name.toString(),
        measureFn: (Chart chart, _) => chart.value,
        colorFn: (Chart chart, _) =>
            charts.ColorUtil.fromDartColor(Colors.black),
        id: 'Chart',
        data: mydata,
        labelAccessorFn: (Chart row, _) => "${row.name}: ${row.value}"));
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
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
      body: FutureBuilder(
      future: data.fetchChart(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return _buildChart(context, snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
    );
  }

  // Widget _buildBody(context) {
  //  // var data = context.watch<Data>();
  //   return 
  // }

  Widget _buildChart(BuildContext context, List<Chart> chart) {
    mydata = chart;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Chart",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 3),
                  behaviors: [
                    new charts.DatumLegend(
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxColumns: 2,
                      cellPadding: new EdgeInsets.only(
                          right: 4.0, bottom: 4.0, top: 4.0),
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

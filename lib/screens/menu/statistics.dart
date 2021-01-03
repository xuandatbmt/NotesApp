import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
            return BuildChar(datas: snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class BuildChar extends StatefulWidget {
  final datas;
  BuildChar({Key key, this.datas}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BuildCharState();
  }
}

class _BuildCharState extends State<BuildChar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        dataMap: widget.datas,
        chartRadius: 300,
        chartValuesOptions: ChartValuesOptions(
            chartValueStyle:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            showChartValueBackground: false,
            showChartValuesInPercentage: true),
        legendOptions: LegendOptions(
            legendPosition: LegendPosition.top,
            showLegends: true,
            legendTextStyle:
                (TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        animationDuration: Duration(microseconds: 2000),
      ),
    );
  }
}

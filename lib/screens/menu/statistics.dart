import 'package:notes/themes/colors.dart';
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

class Chart {
  final String name;
  final int value;
  Chart(this.name, this.value);
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // @override
  // Widget build(BuildContext context) {
  //   var data = context.watch<Data>();
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.white10,
  //       elevation: 0.0,
  //       title: Text(
  //         "Statistics",
  //         textAlign: TextAlign.right,
  //         style: TextStyle(color: Colors.black),
  //       ),
  //     ),
  //     body: Container(
  //       child: PieChart(
  //         dataMap: ,
  //         chartRadius: 300,
  //         chartValuesOptions: ChartValuesOptions(
  //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //             showChartValueBackground: false,
  //             showChartValuesInPercentage: true),
  //         legendOptions: LegendOptions(
  //             legendPosition: LegendPosition.top,
  //             showLegends: true,
  //             legendTextStyle:
  //                 (TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
  //         animationDuration: Duration(microseconds: 2000),
  //       ),
  //     ),
  //   );

  //  _getData() async{
  //   final response = await http.get('https://api-mobile-app.herokuapp.com/api/count', headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': '$token',
  //   });
  //   Map<String,dynamic> map = json.decode(response.body);
  //   return map;
  // }
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
          style: TextStyle(color: textColor),
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
    // setState(() {
    //   this.data = data(widget.data)
    // });
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

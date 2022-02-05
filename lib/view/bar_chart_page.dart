import 'package:flutter/material.dart';
import 'package:stockbit_tes/bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartPage extends StatelessWidget {
  final String? payload;
  BarChartPage({this.payload});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bar Chart", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: BarChart(
            data: [
              TimeOpen(
                payload,
                DateTime.now().difference(DateTime.parse(payload!)).inSeconds,
                charts.ColorUtil.fromDartColor(
                  Colors.teal,
                ),
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphically_flutter_2/number.dart';
import 'package:graphically_flutter_2/numberItem.dart';
import './task.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  final List<int> entriesList;

  @override
  HomePage({Key key, this.child, this.entriesList}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Task, String>> _seriesPieData; //Pie chart
  List<charts.Series<NumberItem, String>> _seriesBarData; //Bar graph

  _generateData() {
    var barData = [
      new NumberItem(widget.entriesList[0], 3),
      new NumberItem(widget.entriesList[1], 2),
      new NumberItem(widget.entriesList[2], 2),
      new NumberItem(widget.entriesList[3], 5),
      new NumberItem(widget.entriesList[4], 1),
    ];

    //Bar graph handler
    _seriesBarData.add(
      charts.Series(
          domainFn: (NumberItem data, _) => "${data.number}", //X-Axis
          measureFn: (NumberItem data, _) => data.frequency, //Y-Axis
          data: barData,
          id: "dummyId", //TODO
          fillPatternFn: (_, __) =>
              charts.FillPatternType.forwardHatch, //Pattern in rectangle
          fillColorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Color(0xff990099))),
    );
  }

  void initState() {
    super.initState();
    //Initialize bar and pie data
    _seriesPieData = new List();
    _seriesBarData = new List();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff1976d2),
              title: Text('Flutter charts'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.forward),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => EnterNumber()));
                  },
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Click Frequency',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: charts.BarChart(
                          _seriesBarData,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
                          barGroupingType: charts.BarGroupingType.grouped,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

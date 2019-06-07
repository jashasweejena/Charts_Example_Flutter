import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphically_flutter_2/number.dart';
import 'package:graphically_flutter_2/numberItem.dart';
import './pollution.dart';
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
  
  _generateData(){
    //For PieChart
    var pieData = [
      new Task("Work", 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff990099)),
      new Task('Commute', 10.8, Color(0xff109618)),
      new Task('TV', 15.6, Color(0xffdbe19)),
      new Task('Sleep', 19.2, Color(0xffff9900)),
      new Task('Other', 10.3, Color(0xffdc3912))
    ];

    //For BarChart
    var data1 = [
      new Pollution(1980, 'USA', 30),
      new Pollution(1980, 'Asia', 40),
      new Pollution(1980, 'Europe', 10)
    ];

    var data2 = [
      new Pollution(1985, 'USA', 100),
      new Pollution(1980, 'Asia', 150),
      new Pollution(1985, 'Europe', 80),
    ];

    var data3 = [
      new Pollution(1985, 'USA', 200),
      new Pollution(1980, 'Asia', 300),
      new Pollution(1985, 'Europe', 180),
    ];

    var data4 = [
      new NumberItem(widget.entriesList[0], 3),
      new NumberItem(widget.entriesList[1], 2),
      new NumberItem(widget.entriesList[2], 2),
      new NumberItem(widget.entriesList[3], 5),
      new NumberItem(widget.entriesList[4], 1),
    ];

  //Pie chart handler
    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task, //X-Axis 
        measureFn: (Task task, _) => task.taskValue, //Y-Axis
        colorFn: (Task task, _) =>
          charts.ColorUtil.fromDartColor(task.colorVal),
        id: 'Daily Task',
        labelAccessorFn: (Task row, _) => '${row.taskValue}'
      )
    );

    //Bar graph handler
    _seriesBarData.add(
      charts.Series(
        domainFn: (NumberItem data, _) => "${data.number}", //X-Axis
        measureFn: (NumberItem data, _) => data.frequency, //Y-Axis
        data: data4, 
        id: "dummyId", //TODO
        fillPatternFn: (_, __) => charts.FillPatternType.forwardHatch, //Pattern in rectangle
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff990099))
        ),
    );

    // _seriesBarData.add(
    //    charts.Series(
    //     domainFn: (Pollution data, _) => data.place,
    //     measureFn: (Pollution data, _) => data.quantity,
    //     id: '2018',
    //     data: data2,
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Pollution data, _) => charts.ColorUtil.fromDartColor(Color(0xff109618))
    //     ),
    // );

    // _seriesBarData.add(
    //     charts.Series(
    //     domainFn: (Pollution data, _) => data.place,
    //     measureFn: (Pollution data, _) => data.quantity,
    //     id: '2019',
    //     data: data3,
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Pollution data, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900))
    //     )
    // );
  }
  void initState(){
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
                onPressed: (){
                  Navigator.push(
                    context, 
                    new MaterialPageRoute(builder: (context) => EnterNumber()));
                },)
            ],
          ),
          body: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(children: <Widget>[
                      Text(
                        'Click Frequency',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Expanded(
                        child: charts.BarChart(
                          _seriesBarData,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
                          barGroupingType: charts.BarGroupingType.grouped,
                        ),
                      )
                    ],),
                  ),
                ),
              ),
        )
      ),
    );
  }
}




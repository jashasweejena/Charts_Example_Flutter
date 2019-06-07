import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  final Widget child;
  @override
  HomePage({Key key, this.child}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Task, String>> _seriesPieData; //Pie chart
  List<charts.Series<Pollution, String>> _seriesBarData; //Bar graph
  
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
        domainFn: (Pollution data, _) => data.place, //X-Axis
        measureFn: (Pollution data, _) => data.quantity, //Y-Axis
        id: '2017',
        data: data1, 
        fillPatternFn: (_, __) => charts.FillPatternType.forwardHatch, //Pattern in rectangle
        fillColorFn: (Pollution data, _) => charts.ColorUtil.fromDartColor(Color(0xff990099))
        ),
    );

    _seriesBarData.add(
       charts.Series(
        domainFn: (Pollution data, _) => data.place,
        measureFn: (Pollution data, _) => data.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution data, _) => charts.ColorUtil.fromDartColor(Color(0xff109618))
        ),
    );

    _seriesBarData.add(
        charts.Series(
        domainFn: (Pollution data, _) => data.place,
        measureFn: (Pollution data, _) => data.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution data, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900))
        )
    );
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
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: <Widget>[
                Tab(icon: Icon(FontAwesomeIcons.solidChartBar),),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine),)
              ],
            ),
            title: Text('Flutter charts'),
          ),
          body: TabBarView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(children: <Widget>[
                      Text(
                        'SO2 emissions, by world region (in Million tonnes)',
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(children: <Widget>[
                      Text(
                        'Time spent on daily tasks',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Expanded(
                        child: charts.PieChart(
                          _seriesPieData,
                          animate: true,
                          animationDuration: Duration(seconds: 5),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                color: charts.MaterialPalette.purple.shadeDefault,
                                fontFamily: 'Georgia',
                                fontSize: 11),
                            )
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 100,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside
                              )
                            ]
                          ),
                        ),
                      )
                    ],),
                  ),
                ),
              ),
              Container()
            ],
          ),
        )
      ),
    );
  }
}

class Task{
  String task;
  double taskValue;
  Color colorVal;

  Task(this.task, this.taskValue, this.colorVal);
}

class Pollution{
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}
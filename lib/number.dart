import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphically_flutter_2/homepage.dart';
import 'package:numberpicker/numberpicker.dart';

class EnterNumber extends StatefulWidget {
  @override
  _EnterNumberState createState() => _EnterNumberState();
}

class _EnterNumberState extends State<EnterNumber> {
  var _scaffoldKey;

  List<int> entriesList;
  String entriesString;
  int _currentValue = 5;
  int counter = 0;

  var snackBar; //TODO

  final myController = TextEditingController();

  void initState() {
    super.initState();
    entriesList = new List();
    entriesString = "";
    snackBar = SnackBar(content: Text('Sorry, 5 Tries at max'));
    _scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Number"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new NumberPicker.integer(
                initialValue: 5,
                minValue: 5,
                maxValue: 25,
                onChanged: (newValue) => setState(() {
                      _currentValue = newValue;
                    })),
            new Text("Current number: " + '$_currentValue'),
            SizedBox(
              height: 40.0,
            ),
            MaterialButton(
              color: Colors.blue,
              child: Text('Done'),
              onPressed: () {
                setState(() {
                  counter++;
                  entriesList.add(_currentValue);
                  if (counter <= 5)
                    entriesString = entriesString + " $_currentValue";
                  else
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(entriesString)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage(entriesList: entriesList,)),
  );

        },
        backgroundColor: Colors.red,
      ),
    );
  }

  appendNumber(String number) {
    setState(() {
      entriesList.add(int.parse(number));
      entriesString = entriesString + " " + '$number';
    });
  }
}

# Graphically

First of all, a few screenshots:

Login Page!          
:-------------------------:|
![First](https://github.com/jashasweejena/Graphically-Yours/raw/master/screenshots/flutter_03.png)  

Bar Graph             |  NumberPicker
:-------------------------:|:-------------------------:
![](https://github.com/jashasweejena/Graphically-Yours/raw/master/screenshots/flutter_01.png)  |  ![](https://github.com/jashasweejena/Graphically-Yours/raw/master/screenshots/flutter_02.png)


## What is this?

This is a simple App which uses the charts_flutter library to draw Bar graphs on the frequency of the numbers from 5 user inputs.


## Dependencies

The focus of this project lies on taking user data and drawing a bar graph based on it.

- charts_flutter Library
- font_awesome_flutter Library
- numberpicker Library

## Supported devices

The App supports every device with a Android Jelly Bean, v16, 4.1.x or newer, and iOS 8 or newer.


## Quick walkthrough

### pubspec.yaml

This file helps us define the libraries used in our app

```xml
    dependencies:
      charts_flutter: ^0.6.0
      font_awesome_flutter: ^8.4.0
      numberpicker: ^1.0.0
```

### Base classes

*HomePage* shows the Bar graph after receiving data from the EnterNumber class

*EnterNumber* is the class which launches when the app begins. The user uses a NumberPicker to enter his 5 choices and pressses the FAB to Navigate back to Homepage

*NumberItem* is the class which is a model class for the Bar graph






 


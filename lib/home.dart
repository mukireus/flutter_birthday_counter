import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: GradientColors.green)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Birtday Counter", style: _appTextStyle),
            Text(dateTime == null ? "Bir tarih seçiniz" : dateTime.toString(), style: _appTextStyle),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.date_range),
      backgroundColor: Color(0xFF348F50),
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget child) {
            return Theme(data: ThemeData.dark(), child: child);
          },
        ).then((date) {
          setState(() {
            dateTime = date;
          });
        });
      },
    );
  }
}

TextStyle get _appTextStyle => TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold);

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:intl/intl.dart'; // https://pub.dev/packages/intl

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime birthday;
  String differenceInDays = "";
  String differenceInHours = "";
  String differenceInMinutes = "";
  String differenceInSec = "";
  final f = new DateFormat('dd.MM.yyyy');
  Timer timer;

  @override
  void initState() {
    hesapla();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => hesapla());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> hesapla() async {
    setState(() {
      final now = DateTime.now();
      differenceInDays = birthday.difference(now).inDays.toString();
      differenceInHours = birthday.difference(now).inHours.toString();
      differenceInMinutes = birthday.difference(now).inMinutes.toString();
      differenceInSec = birthday.difference(now).inSeconds.toString();

      print("Now :" + now.toString());
      print("FarkD : " + differenceInDays);
      print("FarkH : " + differenceInHours);
      print("FarkM : " + differenceInMinutes);
    });
  }

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
            Text("Birtday Counter", style: _appTextStyle(26)),
            Text(birthday == null ? "Bir tarih seçiniz" : "Seçilen Tarih : " + f.format(birthday).toString(), style: _appTextStyle(26)),
            Text("Doğum  Kalan Süre:", style: _appTextStyle(26)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _counterContainer("Gün", differenceInDays),
                _counterContainer("Saat", differenceInHours),
                _counterContainer("Dakika", differenceInMinutes),
                _counterContainer("Saniye", differenceInSec),
              ],
            ),
            RaisedButton(
              onPressed: () {
                hesapla();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _counterContainer(String text, String text2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text2, style: _appTextStyle(20)),
            Text(text, style: _appTextStyle(20)),
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
          lastDate: DateTime(2022),
          builder: (BuildContext context, Widget child) {
            return Theme(data: ThemeData.dark(), child: child);
          },
        ).then((date) {
          setState(() {
            birthday = date;
            DateTime dateTimeNow = DateTime.now();
            differenceInDays = dateTimeNow.difference(birthday).inDays.toString();
            differenceInHours = dateTimeNow.difference(birthday).inHours.toString();
            differenceInMinutes = dateTimeNow.difference(birthday).inMinutes.toString();
            differenceInSec = dateTimeNow.difference(birthday).inSeconds.toString();

            print(differenceInDays);
          });
        });
      },
    );
  }
}

TextStyle _appTextStyle(double size) => TextStyle(color: Colors.white, fontSize: size, fontWeight: FontWeight.bold);

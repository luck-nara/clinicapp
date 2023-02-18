//import 'package:clinicapp/screen/api.dart';
// ignore: unused_import
// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/admin/loginadmin.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/register.dart';
import 'package:clinicapp/utility/normal_dailog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utility/my_style.dart';
import 'Bar.dart';
import '../api/api.dart';
//$Recycle.Bin 'api.dart';

class WellcomeScreen extends StatefulWidget {
  @override
  _WellcomeScreenState createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: Color.fromRGBO(124, 185, 163, 1),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 360,
                  child: Stack(children: [
                    Positioned(
                        child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/backg.png"),
                              fit: BoxFit.fill)),
                    ))
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "แอปพลิเคชั่นค้นหาคลินิก",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'NotoSansThai'),
                        )
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "เริ่มต้นการใช้งาน",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai'),
                        )
                      ]),
                ),
                SizedBox(
                  height: 30,
                ),
                loginButton(),
                SizedBox(
                  height: 30,
                ),
                loginButton2(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }

  Widget loginButton() => Container(
        child: AnimatedButton(
          width: 350.0,
          height: 100,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            Navigator.push(context(), MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
          },
          child: Text(
            "สำหรับผู้ใช้งาน",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'NotoSansThai'),
          ),
        ),
      );

  Widget loginButton2() => Container(
        child: AnimatedButton(
          width: 350.0,
          height: 100,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            Navigator.push(context(), MaterialPageRoute(builder: (context) {
              return LoginAdminScreen();
            }));
          },
          child: Text(
            "สำหรับผู้ดูแลระบบ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'NotoSansThai'),
          ),
        ),
      );
  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromRGBO(251, 182, 6, 1),
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }
}

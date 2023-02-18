//import 'package:clinicapp/screen/api.dart';
// ignore: unused_import
// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/admin/baradmin.dart';

import 'package:clinicapp/admin/indexadmin.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/config.dart';
import 'package:clinicapp/screen/index.dart';
import 'package:clinicapp/screen/register.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/utility/add.dart';
import 'package:clinicapp/utility/normal_dailog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utility/my_style.dart';
import '../api/api.dart';
//$Recycle.Bin 'api.dart';

class LoginAdminScreen extends StatefulWidget {
  @override
  _LoginAdminScreenState createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  // ignore: unused_field
  String _userAdmin = "";
  // ignore: unused_field
  String _passwordAdmin = "";
  ApiProvider api3 = ApiProvider();
  // ignore: unused_field
  TextEditingController _ctrlUserAdmin = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlPasswordAdmin = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  Future<Null> doLoginadmin() async {
    String path = "${Config.url}/loginadmin";
    await Dio().post(path).then((value) => print("### value = $value"));
  }

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
                        "ผู้ดูแลระบบ",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'NotoSansThai'),
                      )
                    ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0), //ซ้าย,บน,ขวา,ล่าง

                child: Container(
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 1),
                        Color.fromRGBO(255, 255, 255, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "ชื่อผู้ใช้  : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai'),
                        ),
                        Container(
                          width: 230,
                          child: TextField(
                            onChanged: (value) => _userAdmin = value,
                            controller: _ctrlUserAdmin,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              //hintText: 'ชื่อผู้ใช้',
                              hintStyle: TextStyle(color: hintText),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "รหัสผ่าน : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai'),
                        ),
                        Container(
                          width: 230,
                          child: TextField(
                            onChanged: (value) => _passwordAdmin = value.trim(),
                            obscureText: true,
                            controller: _ctrlPasswordAdmin,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              // hintText: 'รหัสผ่าน',
                              hintStyle: TextStyle(color: hintText),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              loginButton(),
              regiterForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Row regiterForm(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: TextButton(
            child: const Text(
              'เริ่มต้นใช้งาน',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'NotoSansThai'),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WellcomeScreen();
              }));
            },
          ),
        ),
      ],
    );
  }

  Widget loginButton() => Container(
        child: AnimatedButton(
          width: 350.0,
          height: 50,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            if (_userAdmin == null ||
                _userAdmin.isEmpty ||
                _passwordAdmin == null ||
                _passwordAdmin.isEmpty) {
              showDialog(
                  context: context(),
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('กรุณากรอกข้อมูลให้ครบถ้วน ! ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'NotoSansThai')),
                      actions: [
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('เข้าใจเเล้ว',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'NotoSansThai')),
                        )
                      ],
                    );
                  });
            } else {
              final dataAdmin =
                  await api3.doLoginadmin(_userAdmin, _passwordAdmin);
              print(dataAdmin);
              if (dataAdmin != null) {
                Navigator.push(context(), MaterialPageRoute(builder: (context) {
                  return BarAdminScreen();
                }));
              } else {
                showDialog(
                    context: context(),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง ! ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'NotoSansThai')),
                        actions: [
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('เข้าใจเเล้ว',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'NotoSansThai')),
                          )
                        ],
                      );
                    });
              }
            }
          },
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 0, 0, 0),
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

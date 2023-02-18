// ignore: unused_import
import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/api/api.dart';
import 'package:clinicapp/screen/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:clinicapp/model/usermodel.dart';

import '../utility/normal_dailog.dart';
import 'Bar.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ignore: unused_field
  String _firstnameMember = "";
  // ignore: unused_field
  String _lastnameMember = "";
  // ignore: unused_field
  String _tellMember = "";
  // ignore: unused_field
  String _usernameMember = "";
  // ignore: unused_field
  String _passwordMember = "";

  ApiProvider api = ApiProvider();
  //Register api = Register();

  // ignore: unused_field
  TextEditingController _ctrlFirstnameMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlLastnameMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTellMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlUsernameMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlPasswordMember = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(124, 185, 163, 1),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 160,
                  width: 150,
                  child: Image.asset("images/register.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 5),
                      child: IconButton(
                          icon: SizedBox(
                              height: 100,
                              child: Image.asset("images/arrow.png")),
                          iconSize: 50.0,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),*/
                    Text('สมัครสมาชิก',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'NotoSansThai')),
                  ],
                ),
                /* Divider(
                  color: Color.fromRGBO(79, 101, 93, 1), //color of divider
                  height: 5, //height spacing of divider
                  thickness: 2, //thickness of divier line
                  indent: 5, //spacing at the start of divider
                  endIndent: 5, //spacing at the end of divider
                ),*/
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text('ชื่อจริง : ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai')),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Color.fromARGB(255, 0, 0, 0),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            //hintText: 'ที่อยู่คลินิก',
                          ),
                          onChanged: (value) => _firstnameMember = value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'กรุณากรอกชื่อจริง !';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text('นามสกุล : ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai')),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Color.fromARGB(255, 0, 0, 0),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            //hintText: 'ที่อยู่คลินิก',
                          ),
                          onChanged: (value) => _lastnameMember = value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'กรุณากรอกนามสกุล !';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text('เบอร์โทร : ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai')),
                      Expanded(
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: Color.fromARGB(255, 0, 0, 0),
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              //hintText: 'ที่อยู่คลินิก',
                            ),
                            onChanged: (value) => _tellMember = value,
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกเบอร์โทรศัพท์ !';
                              } else if (value[0] != "0") {
                                return 'รูปแบบเบอร์โทรศัพท์ไม่ถูกต้อง !';
                              } else if (value.length != 10) {
                                return 'จำนวนเบอร์โทรศัพท์ไม่ถูกต้อง !';
                              }
                              return null;
                            })),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text('ชื่อผู้ใช้ : ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai')),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Color.fromARGB(255, 0, 0, 0),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            //hintText: 'ที่อยู่คลินิก',
                          ),
                          onChanged: (value) => _usernameMember = value,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อผู้ใช้ !';
                            } else if (!RegExp(r'^[A-Za-z0-9_.]+$')
                                .hasMatch(value)) {
                              return 'ชื่อผู้ใช้ต้องเป็นภาษาอังกฤษเท่านั้น !';
                            }
                            return null;
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text('รหัสผ่าน : ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'NotoSansThai')),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Color.fromARGB(255, 0, 0, 0),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            //hintText: 'ที่อยู่คลินิก',
                          ),
                          onChanged: (value) => _passwordMember = value,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน !';
                            } else if (value.length < 8) {
                              return 'รหัสผ่านขั้นต่ำ 8 ตัวอักษร !';
                            }
                            return null;
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                loginButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      child: const Text(
                        'กลับหน้าเข้าสู่ระบบ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'NotoSansThai'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
        child: AnimatedButton(
          width: 370,
          height: 60,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final dataUser = await api.doRegister(
                  _firstnameMember,
                  _lastnameMember,
                  _tellMember,
                  _usernameMember,
                  _passwordMember);
              print(dataUser);
              Navigator.push(context(), MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            }
          },
          child: Text(
            'สมัครสมาชิก',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 0, 0, 1),
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

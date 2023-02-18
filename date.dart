import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/api/api.dart';
import 'package:clinicapp/api/apiappoint.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/utility/add.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

class DateScreen extends StatefulWidget {
  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  // ignore: unused_field
  String _dateAppoint = "";
  // ignore: unused_field
  String _detailAppoint = "";
  // ignore: unused_field
  String _nameclinicsAppoint = "";
  // ignore: unused_field
  String _idmemberAppoint = "";

  ApiProviderappoint api7 = ApiProviderappoint();

  // ignore: unused_field
  TextEditingController _ctrlDateAppoint = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlDetailAppoint = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlNameclinicsAppoint = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlIdmemberAppoint = TextEditingController();

  final formKeyappoint = GlobalKey<FormState>();

  var _data;

  TextEditingController _date = TextEditingController();
  Future<void> getAppoint() async {
    String path = "${Config.url}/getappoint";
    var data;
    await Dio().get(path).then((value) => {data = value});

    data = json.decode(data.toString());
    //print(data);
    print(data["data"]);
    setState(() {
      _data = data;
    });
  }

  Future<void> deleteAppoint(dynamic data) async {
    String path = "${Config.url}/deleteapppoint";

    var res =
        await Dio().delete(path, data: {"id_appoint": data["id_appoint"]});
    var resJson = json.decode(res.toString());
    getAppoint();
    print(resJson);
    setState(() {
      getAppoint();
    });
  }

  /* Future<void> getClinic() async {
    String path = "${Config.url}/getclinic";
    var data;
    await Dio().get(path).then((value) => data = value);
    data = json.decode(data.toString());
    print(_data);
    setState(() {
      _data = data;
    });
  }*/

  void initState() {
    super.initState();
    getAppoint();
    //getClinic();
    deleteAppoint(dynamic);
    _idmemberAppoint = User.userData["id_member"].toString();
  }

  // DateTime _dateTime = DateTime.now()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 81, 3),
        centerTitle: true,
        title: Text('แอปพลิเคชั่นค้นหาคลินิก',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSansThai')),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BarScreen(
                index: 1,
              );
            }));
          },
          child: Icon(
            Icons.arrow_back_outlined,
            size: 26.0,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WellcomeScreen();
                  }));
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      backgroundColor: Color.fromRGBO(124, 185, 163, 1),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text('บันทึกวันนัดหมาย',
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansThai')),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdddateButton(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: (_data != null)
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        if (_data["data"][i]["id_member"] ==
                            User.userData["id_member"]) {
                          return ListTile(
                              title: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                    /*mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,*/
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Container(
                                          // color: Colors.blue,
                                          //height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              /*Text(User
                                                        .userData["username_member"]
                                                        .toString()),*/
                                              Row(
                                                children: [
                                                  Text("ชื่อคลินิก : ",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          fontFamily:
                                                              'NotoSansThai')),
                                                  Container(
                                                    width: 130,
                                                    child: Text(
                                                        "${_data["data"][i]["name_clinics"]}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            //fontWeight: FontWeight.bold,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontFamily:
                                                                'NotoSansThai')),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("วันที่ : ",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          fontFamily:
                                                              'NotoSansThai')),
                                                  Text(
                                                      "${_data["data"][i]["date_appoint"]}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          //fontWeight: FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          fontFamily:
                                                              'NotoSansThai')),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("รายละเอียด : ",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          fontFamily:
                                                              'NotoSansThai')),
                                                  Container(
                                                    width: 130,
                                                    child: Text(
                                                        "${_data["data"][i]["detail_appoint"]}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            //fontWeight: FontWeight.bold,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontFamily:
                                                                'NotoSansThai')),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, left: 0),
                                        child: Container(
                                          // color: Colors.black,
                                          child: Column(children: [
                                            TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'คุณต้องการที่จะลบวันนัดหมายนี้ใช่หรือไม่ ?',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontFamily:
                                                                    'NotoSansThai')),
                                                        actions: [
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .red),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text('ไม่',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      fontFamily:
                                                                          'NotoSansThai'))),
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .green),
                                                              onPressed:
                                                                  () async {
                                                                deleteAppoint(
                                                                    _data["data"]
                                                                        [i]);
                                                                Navigator.pop(
                                                                    context);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text("ลบวันนัดหมายเรียบร้อยเเล้ว")));
                                                              },
                                                              child: const Text(
                                                                  'ใช่',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      fontFamily:
                                                                          'NotoSansThai'))),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 60,
                                                  child: Image.asset(
                                                      "images/delete.png")),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ])),
                          ));
                        } else {
                          return Container();
                        }
                      },
                      itemCount: _data["data"]?.length ?? 0,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
        ]),
      ),
    );
  }

  AnimatedButton buildCreatAppoint(context) {
    return AnimatedButton(
      color: Color.fromRGBO(79, 101, 93, 1),
      width: 370,
      height: 60,
      onPressed: () async {
        print(_dateAppoint);
        print(_detailAppoint);
        print(_nameclinicsAppoint);
        print(_idmemberAppoint);

        final dataAppoint = await api7.doAppoint(
          _dateAppoint ?? "",
          _detailAppoint ?? "",
          _nameclinicsAppoint ?? "",
          _idmemberAppoint ?? "",
        );
        print(dataAppoint);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BarScreen(
            index: 2,
          );
        }));
      },
      child: Text(
        'บันทึกข้อมูล',
        style: TextStyle(fontSize: 25, color: Color.fromRGBO(251, 182, 6, 1)),
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 48, 48),
          width: 3,
        ));
  }

  void showAlertDialogDate() {
    showDialog(
        context: context(),
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('เพิ่มวันนัดหมาย',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 199, 210, 206),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    decoration: InputDecoration.collapsed(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'ชื่อคลินิก',
                    ),
                    onChanged: (value) => _nameclinicsAppoint = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกชื่อคลินิก';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 199, 210, 206),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                      controller: _date,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.calendar_today),
                        hintText: 'เลือกวันที่',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),

                        //icon: Icon(Icons.calendar_today_rounded),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025));

                        if (pickeddate != null) {
                          print(pickeddate);
                          setState(() {
                            _date.text = DateFormat('yyyy-MM-dd')
                                .format(pickeddate)
                                .toString();
                            _dateAppoint = _date.text;
                          });
                        }
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 199, 210, 206),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    decoration: InputDecoration.collapsed(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'รายละเอียด',
                    ),
                    onChanged: (value) => _detailAppoint = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกรายละเอียด';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ยกเลิก',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'NotoSansThai'))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () async {
                    print(_dateAppoint);
                    print(_detailAppoint);
                    print(_nameclinicsAppoint);
                    print(_idmemberAppoint);
                    if (_nameclinicsAppoint == null ||
                        _nameclinicsAppoint.isEmpty ||
                        _dateAppoint == null ||
                        _dateAppoint.isEmpty ||
                        _detailAppoint == null ||
                        _detailAppoint.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('กรุณากรอกข้อมูลให้ครบถ้วน ! ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontFamily: 'NotoSansThai')),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
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
                      final dataAppoint = await api7.doAppoint(
                        _dateAppoint,
                        _detailAppoint,
                        _nameclinicsAppoint,
                        _idmemberAppoint,
                      );
                      print(dataAppoint);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BarScreen(
                          index: 2,
                        );
                      }));
                    }
                    /*if (formKeyappoint.currentState!.validate()) {
                   
                    }*/
                  },
                  child: const Text('บันทึก',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'NotoSansThai'))),
            ],
          );
        });
  }

  Widget AdddateButton() => Container(
        child: AnimatedButton(
          width: 220,
          height: 50,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            showAlertDialogDate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 30, width: 30, child: Image.asset("images/add.png")),
              SizedBox(
                width: 10,
              ),
              Text("เพิ่มวันนัดหมาย",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansThai')),
            ],
          ),
        ),
      );
}

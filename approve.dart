import 'dart:convert';

import 'package:clinicapp/admin/baradmin.dart';
import 'package:clinicapp/admin/de.dart';
import 'package:clinicapp/admin/indexadmin.dart';
import 'package:clinicapp/admin/viewapprove.dart';
import 'package:clinicapp/model/clinicmodel.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utility/add.dart';
import 'editclinic.dart';

class ApproveScreen extends StatefulWidget {
  const ApproveScreen({Key? key, this.refresh}) : super(key: key);
  @override
  _ApproveScreenState createState() => _ApproveScreenState();

  final refresh;
}

class _ApproveScreenState extends State<ApproveScreen> {
  var _data;

  set searchValue(String searchValue) {}

  Future<void> getClinicawait() async {
    String path = "${Config.url}/getclinicsawaiting";
    var data;
    await Dio().get(path).then((value) => data = value);
    data = json.decode(data.toString());
    print(data["error"]);
    setState(() {
      _data = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gg");
    getClinicawait();
    print(_data);
    test();
  }

  Future<void> test() async {
    await Dio().put('${Config.url}/editwarn', data: {"read_warn": 0});
  }

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
              return BarAdminScreen(
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
          Text('รายชื่อคลินิกที่รออนุมัติ',
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'NotoSansThai')),
          Expanded(
              child: (_data != null)
                  ? FutureBuilder(builder: (context, snapshot) {
                      return ListView.separated(
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Container(
                              padding: EdgeInsets.all(20),
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 220,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${_data["data"][i]["name_waiting"].toString()}"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Container(
                                            child: Center(
                                          child: Image.asset(
                                            "images/3974933.png",
                                            width: 50,
                                          ),
                                        )),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return Add2Screen(
                                                  title: Text("data"),
                                                  data: _data["data"][i],
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return Divider(
                            thickness: 0.5,
                            height: 0.5,
                          );
                        },
                        itemCount: _data["data"]?.length ?? 0,
                      );
                    })
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
        ]),
      ),
    );
  }
}

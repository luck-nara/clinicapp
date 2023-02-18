import 'dart:convert';

import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utility/add.dart';
import 'wellcome.dart';

//$Recycle.Bin 'api.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  var _data;
  String _date = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ถถถถถถถถถถ");
    getAppoin();
  }

  Future<void> getAppoin() async {
    String path = "${Config.url}/getappoint";

    var dataAppoin;
    await Dio().get(path).then((value) => {dataAppoin = value});

    dataAppoin = json.decode(dataAppoin.toString());
    print(dataAppoin);
    print("ๅๅๅๅๅๅๅๅๅๅๅๅๅ");
    print(User.userData["id_member"].toString());
    print("11111111111");
    print(dataAppoin["data"]);
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    print(date.toString().substring(0, 10));
    setState(() {
      _data = dataAppoin["data"];
      _date = date.toString().substring(0, 10);
    });
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
                return BarScreen(
                  index: 2,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
            Text('เเจ้งเตือนวัดนัดหมายปัจจุบัน',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai')),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: (_data != null)
                    ? FutureBuilder(builder: (context, snapshot) {
                        return ListView.separated(
                          itemBuilder: (context, i) {
                            return (_data[i]["id_member"].toString() ==
                                    User.userData["id_member"].toString())
                                ? _date != _data[i]["date_appoint"].toString()
                                    ? ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, top: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
                                                  child: Container(
                                                    //alert.dart color: Colors.amber,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "ชื่อคลินิก : ",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                            Text(
                                                                _data[i][
                                                                        "name_clinics"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("วันที่ : ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                            Text(
                                                                _data[i][
                                                                        "date_appoint"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "รายละเอียด : ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                            Container(
                                                              width: 230,
                                                              child: Text(
                                                                  _data[i][
                                                                          "detail_appoint"]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              1),
                                                                      fontFamily:
                                                                          'NotoSansThai')),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, right: 5, left: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 360,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    /* color: Colors.blue,*/
                                                    width: 320,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "ชื่อคลินิก : ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                            Container(
                                                              /*color:
                                                                  Colors.amber,*/
                                                              width: 200,
                                                              child: Text(
                                                                  _data[i][
                                                                          "name_clinics"]
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              1),
                                                                      fontFamily:
                                                                          'NotoSansThai')),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("วันที่ : ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                            Text(
                                                                _data[i][
                                                                        "date_appoint"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "รายละเอียด : ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            1),
                                                                    fontFamily:
                                                                        'NotoSansThai')),
                                                            Container(
                                                              width: 130,
                                                              /*color:
                                                                  Colors.blue,*/
                                                              child: Text(
                                                                  _data[i][
                                                                          "detail_appoint"]
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              1),
                                                                      fontFamily:
                                                                          'NotoSansThai')),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                : Container();
                          },
                          separatorBuilder: (context, i) {
                            return Container();
                          },
                          itemCount: _data?.length ?? 0,
                        );
                      })
                    : Center(
                        child: CircularProgressIndicator(),
                      ))
          ]),
        ));
  }
}

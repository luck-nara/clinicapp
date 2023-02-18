import 'dart:convert';

import 'package:clinicapp/admin/add.dart';
import 'package:clinicapp/admin/approve.dart';
import 'package:clinicapp/admin/editclinic.dart';
import 'package:clinicapp/admin/loginadmin.dart';
import 'package:clinicapp/screen/dataclinic.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/utility/add.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IndexadminScreen extends StatefulWidget {
  const IndexadminScreen({Key? key}) : super(key: key);

  @override
  State<IndexadminScreen> createState() => _IndexadminScreenState();
}

class _IndexadminScreenState extends State<IndexadminScreen> {
  var _data;
  var sda;
  set searchValue(String searchValue) {}
  TextEditingController _searchController = new TextEditingController();
  String name = "";

  Future<void> getClinic() async {
    String path = "${Config.url}/getclinic";
    var data;
    await Dio().get(path).then((value) => data = value);
    data = json.decode(data.toString());
    print(_data);
    setState(() {
      _data = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gg");
    getClinic();
    print(_data);
    test();
  }

  Future<void> test() async {
    final test = await Dio().get("${Config.url}/getwarn");
    print("wwww");
    print(test.data);
    setState(() {
      sda = test.data["data"][0]["read_warn"];
      print("กกกกก");
      print(sda);
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
          onTap: () {},
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
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('รายชื่อคลินิกทั้งหมด',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'NotoSansThai')),
            sda == 1
                ? Text("มีคลินิกที่รอนุมัติเพิ่มมาใหม่",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'NotoSansThai'))
                : Container(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Color(0xFFe9eaec),
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                cursorColor: Color(0xFF000000),
                controller: _searchController,
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF000000).withOpacity(0.5),
                    ),
                    hintText: "Search",
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: (_data != null)
                  ? FutureBuilder(builder: (context, snapshot) {
                      return ListView.separated(
                        itemBuilder: (context, i) {
                          if (_data["data"][i]["name_clinics"].contains(name)) {
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
                                              "${_data["data"][i]["name_clinics"].toString()}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  fontFamily: 'NotoSansThai')),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                              child: Center(
                                            child: Image.asset(
                                              "images/edit.png",
                                              width: 40,
                                            ),
                                          )),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return EditclinicScreen(
                                                    title: Text("data"),
                                                    data: _data["data"][i],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                            icon: SizedBox(
                                              child: Image.asset(
                                                "images/delete.png",
                                                width: 60,
                                              ),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'คุณต้องการที่จะลบคลินิกนี้ใช่หรือไม่ ?',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              fontFamily:
                                                                  'NotoSansThai')),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Colors
                                                                        .red),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'ไม่',
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                                        primary: Colors
                                                                            .green),
                                                            onPressed:
                                                                () async {
                                                              delete(
                                                                  _data["data"]
                                                                      [i]);
                                                              Navigator.pop(
                                                                  context);
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("ลบคลินิกเรียบร้อยเเล้ว")));
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
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        separatorBuilder: (context, i) {
                          return Container();
                        },
                        itemCount: _data["data"]?.length ?? 0,
                      );
                    })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> delete(dynamic data) async {
    String path = "${Config.url}/deleteclinic";

    var res =
        await Dio().delete(path, data: {"id_clinics": data["id_clinics"]});
    var resJson = json.decode(res.toString());
    getClinic();
    print(resJson);
    setState(() {
      getClinic();
    });
  }
}

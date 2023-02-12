import 'dart:convert';

import 'package:clinicapp/admin/indexadmin.dart';
import 'package:clinicapp/admin/loginadmin.dart';
import 'package:clinicapp/model/clinicmodel.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utility/add.dart';
import 'editclinic.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({Key? key, this.refresh}) : super(key: key);
  @override
  _CrudScreenState createState() => _CrudScreenState();

  final refresh;
}

class _CrudScreenState extends State<CrudScreen> {
  var _data;

  set searchValue(String searchValue) {}

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 170, 170, 170),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return IndexadminScreen();
                  },
                ),
              );
            }
          },
        ),
        centerTitle: true,
        title: Image.asset(
          "images/search.png",
          width: 50,
        ),
        backgroundColor: Color.fromRGBO(41, 52, 48, 1),
      ),
      body: Column(
        children: [
          Text("รายชื่อคลินิกทั้งหมด"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${_data["data"][i]["name_clinics"].toString()}"),
                                    ],
                                  ),
                                ]),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                          child: Center(
                                        child: Image.asset(
                                          "images/edit.png",
                                          width: 50,
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
                                            width: 50,
                                          ),
                                        ),
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              //title: const Text('ตำเเหน่งปัจจุบัน'),
                                              content: Text(
                                                  "คุณแน่ใจเเล้วใช่ไหมว่าจะลบคลินิกที่เลือก?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'ยกเลิก'),
                                                  child: const Text('ยกเลิก'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    delete(_data["data"][i]);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("ยืนยัน"),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
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
                  ),
          ),
          Container(
            height: 80,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Color.fromRGBO(41, 52, 48, 1),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    "images/home1.png",
                    color: Colors.white,
                    width: 60,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IndexadminScreen();
                    }));
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    "images/logout.png",
                    color: Colors.white,
                    width: 60,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginAdminScreen();
                    }));
                  },
                ),
              ],
            ),
          ),
        ],
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

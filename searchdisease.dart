import 'dart:convert';

import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/dataclinic.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/utility/add.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchdiseaseScreen extends StatefulWidget {
  @override
  _SearchdiseasScreenState createState() => _SearchdiseasScreenState();
}

class _SearchdiseasScreenState extends State<SearchdiseaseScreen> {
  var _data;
  Future<void> getClinic() async {
    String path = "${Config.url}/getclinic";
    var data;

    await Dio().get(path).then((value) => data = value);
    data = json.decode(data.toString());
    print(_data);
    setState(() {
      _data = data["data"];
    });
  }

  String name = "";
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gg");
    getClinic();
    print(_data);
  }

  TextEditingController _searchController = new TextEditingController();
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
                  index: 6,
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
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10), //ซ้าย,บน,ขวา,ล่าง
              child: Container(
                child: Column(children: [
                  Text('ค้นหาคลินิกตามโรคเฉพาะทาง',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansThai')),
                ]),
              ),
            ),
            Container(
              width: 350,
              height: 40,
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            if (_data[i]["type_clinics"].contains(name)) {
                              return ListTile(
                                title: Container(
                                    width: 350,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Image.network(
                                                _data[i]["img_clinics"]
                                                    .toString(),
                                                fit: BoxFit.fill),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 240,
                                            child: Text(
                                                _data[i]["name_clinics"]
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    fontSize: 20,
                                                    //fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'NotoSansThai')),
                                          ),
                                        ],
                                      ),
                                    )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DataclinicScreen(
                                          title: Text("data"),
                                          data: _data[i],
                                        );
                                      },
                                    ),
                                  );
                                  print(_data);
                                },
                              );
                            } else {
                              return Container();
                            }
                            /* ? Text(_data[i]["name_clinics"].toString())
                            */
                          },
                          separatorBuilder: (context, i) {
                            return Container();
                          },
                          itemCount: _data?.length ?? 0,
                        );
                      })
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ]),
        ));
  }
}

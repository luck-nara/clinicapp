import 'dart:convert';

import 'package:clinicapp/admin/de.dart';
import 'package:clinicapp/admin/indexadmin.dart';
import 'package:clinicapp/admin/viewapprove.dart';
import 'package:clinicapp/model/clinicmodel.dart';
import 'package:clinicapp/screen/profile/profile.dart';
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
      body: (_data != null)
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${_data["data"][i]["name_waiting"].toString()}"),
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
            ),
    );
  }
}

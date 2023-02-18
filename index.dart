import 'dart:convert';

import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/index2.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/search/search.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haversine_distance/haversine_distance.dart';

import '../utility/add.dart';
import 'dataclinic.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key, required Text title, required this.data})
      : super(key: key);
  final data;

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  var _data;
  var _dataHot;
  late String distance = "";
  late Position? _position;
  Position? position;

  set searchValue(String searchValue) {}
  late GoogleMapController mapController;

  final startCoordinate = new Location(60.389739, 5.322323);
  final endCoordinate = new Location(60.393032, 5.327248);

  final haversineDistance = HaversineDistance();
//haversineDistance.haversine(startCoordinate, endCoordinate, Unit.KM).floor();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position?> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _position = await Geolocator.getCurrentPosition();
    // print(widget.data["latitude_clinics"]);
    // print(widget.data["longitude_clinics"]);
    print("1111111111111111111");
    //final haversineDistance = HaversineDistance();

    /// Then calculate the distance between the two location objects and set a unit.
    /// You can select between KM/MILES/METERS/NMI
    ///
    ///
    ///
    ////*
    /*
    final dis = haversineDistance
        .haversine(
            Location(_position!.latitude!, _position!.longitude!),
            Location(double.parse(widget.data["latitude_clinics"]),
                double.parse(widget.data["longitude_clinics"])),
            Unit.KM)
        .floor();
  
    setState(() {
      distance = dis.toString();
    });
          */
    print(_position);
    return _position;
  }

  Future<void> getClinic() async {
    String path = "${Config.url}/getclinic";
    String pathComment = "${Config.url}/getcomments";
    var data, dataHot;
    await Dio().get(path).then((value) => {data = value});
    await Dio().get(pathComment).then((value) => {dataHot = value});

    data = json.decode(data.toString());
    dataHot = json.decode(dataHot.toString());

    //print(data);
    //print(data["data"].length);
    final haversineDistance = HaversineDistance();
    Position? position = await _getLocation() as Position?;

    for (int i = 0; i < data["data"].length; i++) {
      // print(i.toString());
      try {
        final dis = await haversineDistance
            .haversine(
                Location(position!.latitude!, position!.longitude!),
                Location(double.parse(data["data"][i]["latitude_clinics"]),
                    double.parse(data["data"][i]["longitude_clinics"])),
                Unit.KM)
            .floor();
        data["data"][i]["dis"] = dis;
        //config.dart(dis);
      } catch (err) {
        data["data"][i]["dis"] = 100000000000000000000000000.0;
      }
    }

    Map<String, dynamic> tempStar = {};
    Map<String, dynamic> tempStarCount = {};
    for (int i = 0; i < dataHot["data"].length; i++) {
      dynamic tempCount =
          tempStar[dataHot["data"][i]["id_clinics"].toString()] ?? 0;

      dynamic tempCountAvg =
          tempStarCount[dataHot["data"][i]["id_clinics"].toString()] ?? 0;
      //print(dataHot["data"][i]["id_clinics"].toString());
      //print(tempCountAvg);
      tempStar[dataHot["data"][i]["id_clinics"].toString()] =
          tempCount + dataHot["data"][i]["star_comment"];

      tempStarCount[dataHot["data"][i]["id_clinics"].toString()] =
          tempCountAvg + 1;

      try {} catch (err) {
        // data["data"][i]["dis"] = 100000000000000000000000000.0;
      }
    }

    print(tempStar);
    print(tempStarCount);

    tempStar.forEach((key, value) {
      tempStar[key] = value / tempStarCount[key];
    });
    print(tempStar);
    var sortMapByValue = Map.fromEntries(tempStar.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    print(sortMapByValue);

    int countHot = 0;
    List<dynamic> Hot = [];
    List<dynamic> datahot = [];
    sortMapByValue.forEach((key, value) {
      countHot += 1;

      Hot.add({"id": key, "value": value});
    });

    for (int a = 0; a < Hot.length; a++) {
      for (int k = 0; k < data["data"].length; k++) {
        print(Hot[a]["id"]);
        if (data["data"][k]["id_clinics"].toString() ==
            Hot[a]["id"].toString()) {
          data["data"][k]["star"] = Hot[a]["value"].round();
          ;
          datahot.add(data["data"][k]);
        }
      }
    }

    final temp = List.from(data["data"]);
    temp.sort((a, b) => a["dis"].compareTo(b["dis"]));
    data["data"] = temp;
    //print(temp.length);
    // print(data["data"]);
    print(datahot);
    setState(() {
      _data = data;
      _dataHot = datahot;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _determinePosition();
    //_getLocation();
    getClinic();
    print(_data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 81, 3),
          centerTitle: true,
          title: Text(
            'แอปพลิเคชั่นค้นหาคลินิก',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSansThai'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen();
              }));
            },
            child: Icon(
              Icons.person,
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
        body: Center(
            child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BarScreen(index: 6);
                  }));
                },
                child: Container(
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(3, 60, 39, 1),
                        Color.fromRGBO(5, 94, 61, 1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        height: 130,
                        width: 150,
                        child: Image.asset("images/barsearch.png")),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'ค้นหาคลินิก',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'NotoSansThai'),
                        ),
                        Text('ที่ต้องการพบ',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: 'NotoSansThai'))
                      ]),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return IndexScreen(
                          data: null,
                          title: Text(""),
                        );
                      }));
                    },
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(251, 182, 6, 1),
                            Color.fromRGBO(251, 182, 6, 1)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(54, 202, 0, 0.451),
                            offset: Offset(5, 5),
                            blurRadius: 1,
                          )
                        ],
                      ),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "คลินิกคน",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'NotoSansThai'),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BarScreen(index: 5);
                      }));
                    },
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0).withOpacity(0.1),
                            Colors.transparent.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "คลินิกสัตว์",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(2, 2, 2, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'NotoSansThai'),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),

              /*Divider(
                    color: Color.fromRGBO(0, 0, 0, 1), //color of divider
                    height: 5, //height spacing of divider
                    thickness: 2, //thickness of divier line
                    indent: 170, //spacing at the start of divider
                    endIndent: 10, //spacing at the end of divider
                  ),*/
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10), //ซ้าย,บน,ขวา,ล่าง
                  child: Text(
                    'คลินิกบริเวณใกล้เคียง',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai'),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: (_data != null)
                      ? FutureBuilder(builder: (context, snapshot) {
                          return Container(
                            //color: Colors.amber,
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, i) {
                                  if (_data["data"][i]["type_clinics"] !=
                                      "คลินิกสัตว์") {
                                    return Container(
                                      //color: Colors.black,
                                      width: 200,
                                      child: Card(
                                        elevation: 6.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 0.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Column(children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return DataclinicScreen(
                                                        title: Text("data"),
                                                        data: _data["data"][i],
                                                      );
                                                    },
                                                  ),
                                                );
                                                print(_data);
                                              },
                                              child: Container(
                                                //color: Colors.blue,
                                                width: 170,
                                                height: 180,
                                                child: Center(
                                                  child: Column(children: [
                                                    Image.network(
                                                        "${_data["data"][i]["img_clinics"].toString()}",
                                                        width: 300,
                                                        height: 100,
                                                        fit: BoxFit.fill
                                                        // height: 200,
                                                        // width: 200,
                                                        ),
                                                    Text(
                                                      "${_data["data"][i]["name_clinics"].toString()}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          /*fontWeight:
                                                              FontWeight.bold,*/
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'NotoSansThai'),
                                                    ),
                                                    Text(
                                                      "ระยะทาง ${_data["data"][i]["dis"].toString()} กิโลเมตร",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                          /*fontWeight:
                                                              FontWeight.bold,*/
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'NotoSansThai'),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          );
                        })
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0), //ซ้าย,บน,ขวา,ล่าง
                  child: Text('คลินิกยอดนิยมในขณะนี้',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'NotoSansThai'))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: (_data != null)
                      ? FutureBuilder(builder: (context, snapshot) {
                          return Container(
                            //color: Colors.amber,
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, i) {
                                  if (_dataHot[i]["type_clinics"] !=
                                      "คลินิกสัตว์") {
                                    return Container(
                                      //color: Colors.black,
                                      width: 200,
                                      child: Card(
                                        elevation: 6.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 0.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Column(children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return DataclinicScreen(
                                                        title: Text("data"),
                                                        data: _dataHot[i],
                                                      );
                                                    },
                                                  ),
                                                );
                                                print(_data);
                                              },
                                              child: Container(
                                                //color: Colors.blue,
                                                width: 170,
                                                height: 180,
                                                child: Center(
                                                  child: Column(children: [
                                                    Image.network(
                                                        "${_dataHot[i]["img_clinics"].toString()}",
                                                        width: 300,
                                                        height: 100,
                                                        fit: BoxFit.fill
                                                        // height: 200,
                                                        // width: 200,
                                                        ),
                                                    Text(
                                                        "${_dataHot[i]["name_clinics"].toString()}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            /* fontWeight:
                                                                FontWeight.bold,*/
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'NotoSansThai')),
                                                    Wrap(
                                                        spacing:
                                                            12, // space between two icons
                                                        children: <Widget>[
                                                          for (int j = 0;
                                                              j <=
                                                                  _dataHot[i][
                                                                          "star"] -
                                                                      1;
                                                              j++)
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                        ]),
                                                  ]),
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          );
                        })
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
            ],
          )),
        )));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print(await Geolocator.getCurrentPosition());
    return await Geolocator.getCurrentPosition();
  }

  Widget loginButton() => Container(
        height: 50,
        width: 120,
        color: Colors.lightGreenAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                'คลินิกรักษาสัตว์',
                style:
                    TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              onPressed: () {
                Navigator.push(context(), MaterialPageRoute(builder: (context) {
                  return BarScreen(index: 4);
                }));
              },
            )
          ],
        ),
      );
}

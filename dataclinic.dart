import 'dart:convert';
import 'dart:math';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/screen/ae.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/map.dart';
import 'package:clinicapp/screen/map.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/register.dart';
import 'package:clinicapp/screen/testmap.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:clinicapp/screen/comment.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haversine_distance/haversine_distance.dart';
// ignore: unused_import
import 'package:geolocator/geolocator.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:haversine_distance/haversine_distance.dart';

import '../utility/add.dart';

class DataclinicScreen extends StatefulWidget {
  const DataclinicScreen({Key? key, required Text title, required this.data})
      : super(key: key);
  final data;
  @override
  State<DataclinicScreen> createState() => _DataclinicScreenState();
}

class _DataclinicScreenState extends State<DataclinicScreen> {
  late String distance = "";
  var _data;
  late Position? _position;
  @override
  late GoogleMapController mapController;

  final startCoordinate = new Location(60.389739, 5.322323);
  final endCoordinate = new Location(60.393032, 5.327248);

  final haversineDistance = HaversineDistance();
  var star = "";
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
    print(widget.data["latitude_clinics"]);
    print(widget.data["longitude_clinics"]);
    print("1111111111111111111");
    final haversineDistance = HaversineDistance();

    /// Then calculate the distance between the two location objects and set a unit.
    /// You can select between KM/MILES/METERS/NMI
    ///
    ///
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
    return _position;
  }

  Future<void> getClinic() async {
    String path = "${Config.url}/getclinic";
    var data;

    final response = await Dio().get(path);
    //print("${response} )0000");
    data = json.decode(response.toString());
    //print(_data);

    setState(() {
      _data = data["data"];
    });
  }

  Future<void> getComments() async {
    String path = "${Config.url}/getcomments";
    String pathUser = "${Config.url}/getmember";

    var datacomment;
    await Dio().get(path).then((value) => {datacomment = value});
    double? _star = 0;
    datacomment = json.decode(datacomment.toString());
    int count = 0;
    for (int i = 0; i < datacomment["data"].length; i++) {
      //print(datacomment["data"][i]["star_comment"]);
      if (datacomment["data"][i]["id_clinics"] == widget.data["id_clinics"]) {
        _star = (_star! + datacomment["data"][i]["star_comment"]!);
        count += 1;
      }
    }

    setState(() {
      star = (_star! / count).toStringAsFixed(2);
      /* star = (_star! / datacomment["data"].length).toStringAsFixed(2);*/
    });
  }

  void initState() {
    // TODO: implement initState

    super.initState();
    print(widget.data[0]);
    getClinic();
    _determinePosition();
    _getLocation();
    getComments();
    print(star + "อิอิ");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Navigator.pop(context);
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
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('ข้อมูลคลินิก',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansThai')),
                  distance != ""
                      ? SingleChildScrollView(
                          child: SafeArea(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 260,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.451),
                                          offset: Offset(5, 5),
                                          blurRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.network(
                                              "${widget.data["img_clinics"].toString()}",
                                              width: 230,
                                              height: 150,
                                              fit: BoxFit.fill),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/home.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('ชื่อคลินิก : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    '${widget.data["name_clinics"].toString()}',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/rayatang.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('ระยะทาง : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${distance ?? "ไม่บอก"} กม.",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/tell.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('เบอร์โทร : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${widget.data["tell_clinics"].toString()}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/time.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 280,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('เวลาทำการ : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${widget.data["time_clinics"].toString()}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/address.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 280,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('ที่อยู่ : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${widget.data["address_clinics"].toString()}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/type.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('ประเภทของคลินิก : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${widget.data["type_clinics"].toString()}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/detail.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 280,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('รายละเอียด : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${widget.data["detail_clinics"].toString()}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/car.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'เเนะนำยานพาหนะในการเดินทาง : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(
                                                    "${widget.data["vehicle_clinics"].toString()}",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/star.png",
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('คะเเนนดาว : ',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        /* fontWeight:
                                                            FontWeight.bold,*/
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                                Text(star,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'NotoSansThai')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(
                                        79, 101, 93, 1), //color of divider
                                    height: 5, //height spacing of divider
                                    thickness: 2, //thickness of divier line
                                    indent: 5, //spacing at the start of divider
                                    endIndent:
                                        5, //spacing at the end of divider
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [CommentButton(), MapButton()],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : (Center(
                          child: CircularProgressIndicator(),
                        )),
                ],
              ),
            ),
          ))),
    );
  }

  Widget CommentButton() => Container(
        child: AnimatedButton(
          width: 170,
          height: 100,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            Navigator.push(context(), MaterialPageRoute(builder: (context) {
              return CommentScreen(idClinics: widget.data["id_clinics"]);
            }));
          },
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  "images/comment.png",
                  height: 70,
                ),
                Text(
                  'แสดงความคิดเห็น',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'NotoSansThai'),
                ),
              ],
            ),
          ),
        ),
      );
  Widget MapButton() => Container(
        child: AnimatedButton(
          width: 170,
          height: 100,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            Navigator.push(context(), MaterialPageRoute(builder: (context) {
              return MapScreen(
                data: {
                  "lat": widget.data["latitude_clinics"],
                  "lng": widget.data["longitude_clinics"],
                  "cur": _position,
                  "nm": widget.data["name_clinics"],
                },
              );
            }));
          },
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  "images/map.png",
                  height: 70,
                ),
                Text(
                  'นำทางไปยังคลินิก',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'NotoSansThai'),
                ),
              ],
            ),
          ),
        ),
      );

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
}

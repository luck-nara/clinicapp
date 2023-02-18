import 'package:clinicapp/screen/ae.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/utility/add.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utility/normal_dailog.dart';
import '../Bar.dart';
import 'addclinic.dart';

class MapclinicScreen extends StatefulWidget {
  @override
  _MapclinicScreenState createState() => _MapclinicScreenState();
}

class _MapclinicScreenState extends State<MapclinicScreen> {
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
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

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
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
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 15),
              markers: {
                Marker(
                    markerId: MarkerId("ตำเเหน่งปัจจุบัน"),
                    position:
                        LatLng(userLocation.latitude, userLocation.longitude)),
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(userLocation.latitude, userLocation.longitude), 18));
          showAlertDialog();

          print("vbvb");
        },
        backgroundColor: Color.fromARGB(255, 10, 81, 3),
        label: Text("ส่งตำเเหน่ง",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSansThai')),
        icon: Icon(Icons.near_me),
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
        context: context(),
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ตำเเหน่งปัจจุบันของคลินิก',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ค่าละติจูด คือ ${userLocation.latitude} ',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,
                        fontFamily: 'NotoSansThai')),
                Text('ค่าลองจิจูด คือ  ${userLocation.longitude}',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,
                        fontFamily: 'NotoSansThai')),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ไม่',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai'))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    AddMap.lat = userLocation.latitude;
                    AddMap.lng = userLocation.longitude;
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return BarScreen(
                        index: 1,
                      );
                    }));
                  },
                  child: const Text('ใช่',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai'))),
            ],
          );
        });
  }
}

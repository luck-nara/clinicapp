import 'dart:async';

import 'package:clinicapp/screen/dataclinic.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'my_dialog.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationData? _currentLocation;
  late GoogleMapController mapController;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  // LatLng _soureceLocation = LatLng(16.887715302324054, 99.11921024214752);
  // LatLng _destinationLocation = LatLng(16.87361179705933, 99.13164276196422);
  Completer<GoogleMapController> _googleMapController = Completer();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Null> soureceLocation() async {}

  double? lat, lng;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    super.initState();
    // TODO: implement initState
    getPolyPoints();
    //getCurrentLocation();
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
      body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  widget.data["cur"].latitude, widget.data["cur"].longitude),
              zoom: 20 // number of map view
              ),
          markers: {
            Marker(
                markerId: MarkerId("start"),
                position: LatLng(
                    widget.data["cur"].latitude, widget.data["cur"].longitude)),
            Marker(
                markerId: MarkerId("end"),
                position: LatLng(double.parse(widget.data["lat"]),
                    double.parse(widget.data["lng"]))),
          },
          polylines: Set<Polyline>.of(polylines.values)),
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDEnIzwuus-huYcrDs8if_BwmvEmHUtS-w",
        PointLatLng(widget.data["cur"].latitude, widget.data["cur"].longitude),
        PointLatLng(double.parse(widget.data["lat"]),
            double.parse(widget.data["lng"])));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.black, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) => _currentLocation = location);
    GoogleMapController googleMapController = await _googleMapController.future;
    location.onLocationChanged.listen((newLoc) => {
          _currentLocation = newLoc,
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: 13.5,
                  target: LatLng(newLoc.latitude!, newLoc.longitude!))))
        });
    setState(() {});
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('lat', lat));
  }
}

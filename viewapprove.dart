import 'dart:convert';

import 'package:animated_button/animated_button.dart';

import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/api/apiclinicwaiting.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/screen/widgets/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../../utility/add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: avoid_web_libraries_in_flutter

import '../api/apiclinicwaiting.dart';

class Viewapprove extends StatefulWidget {
  const Viewapprove({Key? key, required Text title, required this.data})
      : super(key: key);
  final data;
  @override
  _ViewapproveState createState() => _ViewapproveState();
}

class _ViewapproveState extends State<Viewapprove> {
  // ignore: unused_field
  // ignore: unused_field
  String _nameWaiting = "";
  // ignore: unused_field
  String _addressWaiting = "";

  // ignore: unused_field
  String _tellWaiting = "";

  // ignore: unused_field
  //String _imgClinics = "";
  // ignore: unused_field
  String _timeWaiting = "";
  // ignore: unused_field
  //String _typeClinics = "";
  // ignore: unused_field
  //String _detailClinics = "";
  // ignore: unused_field
  // ignore: unused_field
  String _latitudeWaiting = "";
  // ignore: unused_field
  String _longitudeWaiting = "";
  // ignore: unused_field

  ApiProviders api3 = ApiProviders();
  //Register api = Register();

  // ignore: unused_field
  TextEditingController _ctrlNameClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlAddressClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTellClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlImgClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTimeClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTypeClinics = TextEditingController();

// ignore: unused_field
  TextEditingController _ctrlDetailClinics = TextEditingController();

// ignore: unused_field
  TextEditingController _ctrlVehicle = TextEditingController();

  final formKey3 = GlobalKey<FormState>();

  String? numberValidator(String value) {
    // ignore: unnecessary_null_comparison
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  // ignore: unused_field
  String _typeWaiting = 'สหคลินิก';
  // ignore: unused_field
  String? _vehicleWaiting;
  static const menuItems = <String>[
    'สหคลินิก',
    'คลินิกสัตว์',
    'เวชกรรม',
    'ทันตกรรม',
    'การพยาบาลและการผดุงครรค์',
    'ศัลยกรรมกระดูกและข้อ',
    'กายยภาพบำบัด',
    'เทคนิคการแพทย์',
    'การแพทย์แผนไทย',
    'แก้ไขความผิดปกติของการสื่อความหมาย',
    'เทคโนโลยีหัวใจและทรวงอก',
    'การแพทย์แผนจีน',
    'รังสีเทคนิก',
    'จิตวิทยาคลินิก',
    'กายอุปกรณ์',
    'กิจกรรมบำบัด',
    'ผิวหนัง',
    'สูตินรีเวช',
    'ฝังเข็ม'
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  static const menuItems2 = <String>[
    'รถทุกชนิด',
    'รถจักรยานยนต์',
  ];
  // ignore: unused_field
  final List<DropdownMenuItem<String>> _dropDownMenuItems2 = menuItems2
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            textAlign: TextAlign.left,
          ),
        ),
      )
      .toList();

  void initState() {
    super.initState();
    setState(() {
      _nameWaiting = widget.data["name_waiting"];
      // ignore: unused_field
      _addressWaiting = widget.data["address_waiting"];

      // ignore: unused_field
      _tellWaiting = widget.data["tell_waiting"];

      // ignore: unused_field
      // _imgClinics = widget.data["img_clinics"];
      // ignore: unused_field
      _timeWaiting = widget.data["time_waiting"];
      // ignore: unused_field
      //_btn1SelectedVal = widget.data["type_waiting"];
      // ignore: unused_field
      // _detailClinics = widget.data["detail_clinics"];
      // ignore: unused_field
      _vehicleWaiting = widget.data["vehicle_waiting"];
      // ignore: unused_field
      _latitudeWaiting = widget.data["latitude_waiting"];
      _longitudeWaiting = widget.data["longitude_waiting"];
      // ignore: unused_fiel
    });
  }

  Row buildName(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: ("ชื่อคลินิก"),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _nameWaiting = value,
          initialValue: widget.data["name_waiting"],
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรอกชื่อคลินิก';
            }
            return null;
          },
        ),
      )
    ]);
  }

  /* Row buildType(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: (widget.data["type"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _typeClinics = value,
          initialValue: widget.data["type_clinics"],
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรอกประเภทของคลินิก';
            }
            return null;
          },
        ),
      )
    ]);
  }*/

  Row buildAddresse(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _addressWaiting = value,
          initialValue: widget.data["address_clinics"],
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรอกที่อยู่คลินิก';
            }
            return null;
          },
        ),
      )
    ]);
  }

  Row buildTell(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          keyboardType: TextInputType.phone,
          decoration: new InputDecoration(
            //labelText: (widget.data["tell"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _tellWaiting = value,
          initialValue: widget.data["tell_clinics"],
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรอกเบอร์โทร';
            }
            return null;
          },
        ),
      )
    ]);
  }

  Row buildTime(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: (widget.data["time"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _timeWaiting = value,
          initialValue: widget.data["time_clinics"],
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรอกเวลาทำการของคลินิก';
            }
            return null;
          },
        ),
      )
    ]);
  }

  Row buildlatitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 180,
        height: 70,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: new InputDecoration(
            // labelText: (widget.data["latitude"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _latitudeWaiting = value,
          initialValue: widget.data["latitude_clinics"],
        ),
      )
    ]);
  }

  /*Row buildimg(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //  labelText: (widget.data["img"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _imgClinics = value,
          initialValue: widget.data["img_clinics"],
        ),
      )
    ]);
  }*/

  Row buildlongitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 180,
        height: 70,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: new InputDecoration(
            // labelText: (widget.data["longitude"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _longitudeWaiting = value,
          initialValue: widget.data["longitude_clinics"],
        ),
      )
    ]);
  }

  Row buildvehicle(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //  labelText: (widget.data["vehicle"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _vehicleWaiting = value,
          initialValue: widget.data["vehicle_clinics"],
        ),
      )
    ]);
  }

  /*Row builddetail(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            // labelText: (widget.data["vehicle"].toString()),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
          ),
          onChanged: (value) => _detailClinics = value,
          initialValue: widget.data["detail_clinics"],
        ),
      )
    ]);
  }*/

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
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
      backgroundColor: Color.fromRGBO(124, 185, 163, 1),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text('อนุมัติคลินิก',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai')),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('ชื่อคลินิก',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            buildName(size),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('ประเภทของคลินิก',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 0, right: 0),
              height: 60,
              width: 370,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 3,
                  ),
                  color: Colors.white),
              child: ListTile(
                //title: const Text('ประเภทคลินิก  :'),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Must be one of items.value.
                    value: _typeWaiting,
                    hint: const Text('1',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _typeWaiting = newValue);
                      }
                    },
                    items: this._dropDownMenuItems,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('ที่อยู่คลินิก',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            buildAddresse(size),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('การติดต่อ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            buildTell(size),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('เวลาทำการของคลินิก',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            buildTime(size),
            Text('ประเภท'),
            //buildType(size),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('รายละเอียดของคลินิก',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('แนะนำรถที่สะดวกต่อการจอด',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 0, right: 0),
              height: 60,
              width: 370,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 3),
                  color: Colors.white),
              child: ListTile(
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _vehicleWaiting,
                    hint: const Text('รถทุกชนิด',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _vehicleWaiting = newValue);
                      }
                    },
                    items: _dropDownMenuItems2,
                  ),
                ),
              ),
            ),
            //buildvehicle(size),
            Row(
              children: [
                Container(
                  width: 180,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('ค่าละติจูด',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('ค่าลองติจูด',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildlatitude(size),
                buildlongitude(size),
              ],
            ),
            Text('ลิงค์รูปภาพ'),
            SizedBox(
              height: 10,
            ),
            buildCreatClinic(context),
          ])),
        ),
      ),
    );
  }

  AnimatedButton buildCreatClinic(context) {
    return AnimatedButton(
      color: Color.fromRGBO(79, 101, 93, 1),
      width: 370,
      height: 60,
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            //title: const Text('ตำเเหน่งปัจจุบัน'),
            content: Text("ยืนยันการแก้ไข้ข้อมูลคิลนิก"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                child: const Text('ยกเลิก'),
              ),
              TextButton(
                onPressed: () async {
                  print(_nameWaiting);
                  var res = await Dio()
                      .put("${Config.url}/editclinicawaiting", data: {
                    "name_waiting": _nameWaiting,
                    "address_waiting": _addressWaiting,
                    "tell_waiting": _tellWaiting,
                    "time_waiting": _timeWaiting,
                    //"type_waiting": _btn1SelectedVal,
                    "vehicle_waiting": _vehicleWaiting,
                    "latitude_waiting": _latitudeWaiting,
                    "longitude_waiting": _longitudeWaiting,
                    "id_waiting": widget.data["id_waiting"]
                  });

                  var resJson = json.decode(res.toString());
                  print(resJson);
                  // Navigator.pop(context);
                  await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BarScreen(
                        index: 0,
                      ),
                    ),
                  );
                },
                child: Text("บันทึก"),
              ),
            ],
          ),
        );
      },
      /* onPressed: () async {
        print(_nameClinics);
        var res =
            await Dio().put("${Config.url}/editclinic", data: {
          "name_clinics": _nameClinics,
          "address_clinics": _addressClinics,
          "tell_clinics": _tellClinics,
          "img_clinics": _imgClinics,
          "time_clinics": _timeClinics,
          "type_clinics": _btn1SelectedVal,
          "detail_clinics": _detailClinics,
          "vehicle_clinics": _vehicleClinics,
          "latitude_clinics": _latitudeClinics,
          "longitude_clinics": _longitudeClinics,
          "id_clinics": widget.data["id_clinics"]
        });

        var resJson = json.decode(res.toString());
        print(resJson);
        // Navigator.pop(context);
        await Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CrudScreen(),
          ),
        );
      },*/
      child: Text(
        'บันทึกการแก้ไข้',
        style: TextStyle(fontSize: 25, color: Color.fromRGBO(251, 182, 6, 1)),
      ),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 0, 0, 0),
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<GlobalKey<FormState>>('formKey3', formKey3));
  }
}

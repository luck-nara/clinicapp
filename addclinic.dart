import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/api/apiclinicwaiting.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/screen/widgets/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import '../../utility/add.dart';
import '../index.dart';
import '../my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: avoid_web_libraries_in_flutter

import '../../api/apiclinicwaiting.dart';
import 'package:image_picker/image_picker.dart';
import 'map_clinic.dart';

class AddclinicScreen extends StatefulWidget {
  const AddclinicScreen({
    Key? key,
    required this.data,
  }) : super(key: key);
  final data;
  @override
  _AddclinicScreenState createState() => _AddclinicScreenState();
}

class _AddclinicScreenState extends State<AddclinicScreen> {
  late Position userLocation;
  late GoogleMapController mapController;

  // ignore: unused_fieldไปgpssหน้าgps
  // ignore: unused_field
  String _nameWaiting = AddClinicuser.nameclinicuser.toString();
  // ignore: unused_field
  String _addressWaiting = AddClinicuser.addressclinicuser.toString();
  // ignore: unused_field
  String _tellWaiting = AddClinicuser.tellclinicuser.toString();
  // ignore: unused_field
  String _timeWaiting = AddClinicuser.timeclinicuser.toString();
  // ignore: unused_field
  String _imgWaiting = AddClinicuser.imgclinicuser.toString();
  // ignore: unused_field
  // ignore: unused_field
  // ignore: unused_field
  String _latitudeWaiting = AddMap.lat.toString();
  // ignore: unused_field
  String _longitudeWaiting = AddMap.lng.toString();
  // ignore: unused_field
  String _detailWaiting = AddClinicuser.detailclinicuser.toString();
// ignore: unused_field
  // String _typeWaiting = AddClinicuser.typeclinicuser.toString();
  //String _vehicleWaiting = AddClinicuser.vehicleclinicuser.toString();
  ApiProviders api4 = ApiProviders();
  //Register api = Register();

  // ignore: unused_field
  TextEditingController _ctrlNameWaiting = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlAddressWaiting = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTellWaiting = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTimeWaiting = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTypeWaiting = TextEditingController();

// ignore: unused_field
  TextEditingController _ctrlVehicleWaiting = TextEditingController();
  // ignore: unused_field
  TextEditingController _ctrlImgWaiting = TextEditingController();
  // ignore: unused_field
  TextEditingController _ctrldedtailWaiting = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? selectedValue;
  String _typeWaiting = AddClinicuser.typeclinicuser.toString();
  String _vehicleWaiting = AddClinicuser.vehicleclinicuser.toString();
  static const menuItems = <String>[
    '-----',
    'สหคลินิก',
    'คลินิกสัตว์',
    'กุมารเวชกรรม',
    'ทันตกรรม',
    'พยาบาลและผดุงครรค์',
    'ศัลยกรรมกระดูกและข้อ',
    'กายยภาพบำบัด',
    'เทคนิคการแพทย์',
    'การแพทย์แผนไทย',
    'หัวใจและทรวงอก',
    'การแพทย์แผนจีน',
    'รังสีเทคนิก',
    'จิตวิทยาคลินิก',
    'กายอุปกรณ์',
    'กิจกรรมบำบัด',
    'ผิวหนัง',
    'สูตินรีเวช',
    'ฝังเข็ม',
    'สมองและระบบประสาท',
    'ระบบทางเดินอาหารและตับ'
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
    '-----',
    'รถทุกชนิด',
    'รถจักรยานยนต์',
  ];
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
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  void initState() {
    super.initState();
  }

  Row buildName(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ชื่อคลินิก : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                initialValue: AddClinicuser.nameclinicuser.toString(),
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) {
                  _nameWaiting = value;
                  AddClinicuser.nameclinicuser = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกชื่อคลินิก !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildAddresse(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ที่อยู่ : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                initialValue: AddClinicuser.addressclinicuser.toString(),
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  //hintText: 'ที่อยู่คลินิก',
                ),
                onChanged: (value) {
                  _addressWaiting = value;
                  AddClinicuser.addressclinicuser = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกที่อยู่คลินิก !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildTime(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('เวลาทำการ : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                initialValue: AddClinicuser.timeclinicuser.toString(),
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // hintText: 'เวลาทำการ',
                ),
                onChanged: (value) {
                  _timeWaiting = value;
                  AddClinicuser.timeclinicuser = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกเวลาทำการ !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildTell(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('เบอร์โทร : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                initialValue: AddClinicuser.tellclinicuser.toString(),
                keyboardType: TextInputType.number,
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  //hintText: 'เบอร์โทรคลินิก',
                ),
                onChanged: (value) {
                  _tellWaiting = value;
                  AddClinicuser.tellclinicuser = value;
                },
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกเบอร์โทร !';
                  } else if (value[0] != "0") {
                    return 'รูปแบบเบอร์โทรไม่ถูกต้อง !';
                  } else if (value.length <= 9) {
                    return 'จำนวนเบอร์โทรไม่ถูกต้อง';
                  } else if (value.length > 10) {
                    return 'จำนวนเบอร์โทรไม่ถูกต้อง';
                  }
                  return null;
                }),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row builddetail(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('รายละเอียด : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
                initialValue: AddClinicuser.detailclinicuser.toString(),
                cursorColor: Color.fromARGB(255, 0, 0, 0),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  //hintText: 'รายละเอียดของคลินิก',
                ),
                onChanged: (value) {
                  _detailWaiting = value;
                  AddClinicuser.detailclinicuser = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกรายละเอียดของคลินิก !';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildlatitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 140,
        height: 30,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          initialValue: AddMap.lat.toString(),
          enabled: false,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            hintText: 'ค่าละติจูด',
          ),
          onChanged: (value) => _latitudeWaiting = value,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกปักหมุดตำเเหน่งของคลินิก !';
            }
            return null;
          },
        ),
      )
    ]);
  }

  Row buildlongitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 140,
        height: 30,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          initialValue: AddMap.lng.toString(),
          enabled: false,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            hintText: 'ค่าละติจูด',
          ),
          onChanged: (value) => _longitudeWaiting = value,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกปักหมุดตำเเหน่งของคลินิก !';
            }
            return null;
          },
        ),
      )
    ]);
  }

  Row buildtype(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('ประเภท : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: ListTile(
                //title: const Text('ประเภทคลินิก  :'),
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Must be one of items.value.
                    value: AddClinicuser.typeclinicuser,
                    hint: Text('-----',
                        overflow: TextOverflow.ellipsis,
                        /*'${AddClinicuser.typeclinicuser != "" ? (AddClinicuser.typeclinicuser) : "สหคลินิก"}'*/
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'NotoSansThai')),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          AddClinicuser.typeclinicuser = newValue;
                          _typeWaiting = newValue;
                        });
                      }
                    },

                    items: this._dropDownMenuItems,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildcar(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 350,
        height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Text('รถที่สะดวก : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: AddClinicuser.vehicleclinicuser,
                    hint: const Text(
                        '-----' /*'${AddClinicuser.vehicleclinicuser != "" ? (AddClinicuser.vehicleclinicuser) : "รถทุกชนิด1"}'*/,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'NotoSansThai')),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          AddClinicuser.vehicleclinicuser = newValue;
                          _vehicleWaiting = newValue;
                        });
                      }
                    },
                    items: this._dropDownMenuItems2,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BarScreen(
                index: 0,
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
      backgroundColor: Color.fromRGBO(124, 185, 163, 1),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text('กรุณากรอกข้อมูลคลินิกที่พบ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai')),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), //ซ้าย,บน,ขวา,ล่าง
              child: GestureDetector(
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  setState(() {
                    imagePath = image!;
                  });
                },
                child: Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      imagePath != null
                          ? Container(
                              height: 160,
                              width: 160,
                              child: Image.file(File(imagePath!.path)))
                          : Container(
                              height: 160,
                              width: 160,
                              child: Image.asset("images/img.png"),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildName(size),
            SizedBox(
              height: 10,
            ),
            buildtype(size),
            SizedBox(
              height: 10,
            ),
            buildAddresse(size),
            SizedBox(
              height: 10,
            ),
            buildTell(size),
            SizedBox(
              height: 10,
            ),
            builddetail(size),
            SizedBox(
              height: 10,
            ),
            buildTime(size),
            SizedBox(
              height: 10,
            ),
            buildcar(size),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), //ซ้าย,บน,ขวา,ล่าง
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MapclinicScreen();
                  }));
                },
                child: Container(
                  height: 145,
                  width: 350,
                  decoration: BoxDecoration(
                    //color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            MapClinicButton(),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              //color: Colors.blue,
                              child: Column(children: [
                                Container(
                                    width: 165,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '    ค่าละติจูด',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'NotoSansThai',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        buildlatitude(size),
                                      ],
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 165,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '    ค่าลองจิจูด',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'NotoSansThai'),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        buildlongitude(size),
                                      ],
                                    )),
                              ]),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CreatClinicButton(),
            SizedBox(
              height: 10,
            ),
          ])),
        ),
      ),
    );
  }

  Widget CreatClinicButton() => Container(
        child: AnimatedButton(
          width: 200,
          height: 60,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            if (_nameWaiting == null ||
                _nameWaiting.isEmpty ||
                _addressWaiting == null ||
                _addressWaiting.isEmpty ||
                _tellWaiting == null ||
                _tellWaiting.isEmpty ||
                _timeWaiting == null ||
                _timeWaiting.isEmpty ||
                _typeWaiting == '-----' ||
                _typeWaiting.isEmpty ||
                _vehicleWaiting == '-----' ||
                _vehicleWaiting.isEmpty ||
                _latitudeWaiting == "0.0" ||
                _latitudeWaiting.isEmpty ||
                _longitudeWaiting == "0.0" ||
                _longitudeWaiting.isEmpty ||
                _detailWaiting == null ||
                _detailWaiting.isEmpty) {
              ScaffoldMessenger.of(context()).showSnackBar(
                  SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบถ้วน!")));
              if (_latitudeWaiting == "0.0" ||
                  _latitudeWaiting.isEmpty ||
                  _longitudeWaiting == "0.0" ||
                  _longitudeWaiting.isEmpty) {
                ScaffoldMessenger.of(context()).showSnackBar(
                    SnackBar(content: Text("กรุณาเพิ่มค่าละติจูดลองติจูด!")));
              }
              if (_typeWaiting == '-----' || _typeWaiting.isEmpty) {
                ScaffoldMessenger.of(context()).showSnackBar(
                    SnackBar(content: Text("กรุณาเลือกประเภทของคลินิก!")));
              }
              if (_vehicleWaiting == '-----' || _vehicleWaiting.isEmpty) {
                ScaffoldMessenger.of(context()).showSnackBar(
                    SnackBar(content: Text("กรุณาเลือกรถที่สะดวกต่อการจอด!")));
              }
            } else {
              if (formKey.currentState!.validate()) {
                final dataClinicuser = await api4.doClinicuser(
                    _nameWaiting,
                    _addressWaiting,
                    _tellWaiting,
                    _timeWaiting,
                    _typeWaiting,
                    _vehicleWaiting,
                    _latitudeWaiting,
                    _longitudeWaiting,
                    _detailWaiting,
                    imagePath,
                    "");
                print(_latitudeWaiting);
                Dio().put('${Config.url}/editwarn', data: {"read_warn": 1});
                ScaffoldMessenger.of(context()).showSnackBar(
                    SnackBar(content: Text("บันทึกข้อมูลเรียบร้อย")));
                Navigator.push(context(), MaterialPageRoute(builder: (context) {
                  return BarScreen(index: 0);
                }));
              }
            }
          },
          child: Row(
            children: [
              SizedBox(
                  height: 30, width: 60, child: Image.asset("images/save.png")),
              Text(
                'บันทึกข้อมูล',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'NotoSansThai'),
              ),
            ],
          ),
        ),
      );
  Widget MapClinicButton() => Container(
        child: AnimatedButton(
          width: 160,
          height: 130,
          color: Colors.green,
          onPressed: () async {
            Navigator.push(context(), MaterialPageRoute(builder: (context) {
              return MapclinicScreen();
            }));
          },
          child: Container(
              width: 160,
              height: 130,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(width: 80, child: Image.asset("images/map.png")),
                  Text('เพิ่มที่อยู่คลินิก',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'NotoSansThai')),
                ],
              )),
        ),
      );

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 1),
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
}

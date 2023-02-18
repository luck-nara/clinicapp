// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/admin/approve.dart';
import 'package:clinicapp/admin/baradmin.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:clinicapp/api/apiclinic.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/api/apiclinicwaiting.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/widgets/show_progress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../utility/add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: avoid_web_libraries_in_flutter

import '../../api/apiclinicwaiting.dart';

class Add2Screen extends StatefulWidget {
  const Add2Screen({Key? key, required Text title, required this.data})
      : super(key: key);
  final data;
  @override
  _Add2ScreenState createState() => _Add2ScreenState();
}

class _Add2ScreenState extends State<Add2Screen> {
  // ignore: unused_field
  // ignore: unused_field
  String _nameClinics = "";
  // ignore: unused_field
  String _addressClinics = "";
  String _tellClinics = "";
  // ignore: unused_field
  String _timeClinics = "";
  // ignore: unused_field
  String _imgClinics = "";
  // ignore: unused_field
  String _detailClinics = "";
  // ignore: unused_field
  // ignore: unused_field
  String _latitudeClinics = "";
  // ignore: unused_field
  String _longitudeClinics = "";
  String _imgoldClinics = "";
  // ignore: unused_field
  String _searchClinics = "";
  // ignore: unused_field

  ApiProvidersadmin api2 = ApiProvidersadmin();
  //Register api = Register();

  // ignore: unused_field
  TextEditingController _ctrlNameClinics = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlAddressClinics = TextEditingController();

  final formKey = GlobalKey<FormState>();
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  var _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _nameClinics = widget.data["name_waiting"];
      // ignore: unused_field
      _addressClinics = widget.data["address_waiting"];
      _tellClinics = widget.data["tell_waiting"];
      // ignore: unused_field
      _timeClinics = widget.data["time_waiting"];
      // ignore: unused_field
      _imgClinics = widget.data["img_waiting"];
      // ignore: unused_field
      _detailClinics = widget.data["detail_waiting"];
      // ignore: unused_field
      // ignore: unused_field
      _latitudeClinics = widget.data["latitude_waiting"];
      // ignore: unused_field
      _longitudeClinics = widget.data["longitude_waiting"];
      _imgoldClinics = widget.data["img_waiting"];
    });
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
                  setState(() {
                    _nameClinics = value;
                  });
                },
                initialValue: widget.data["name_waiting"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรอกชื่อคลินิก';
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
                  setState(() {
                    _addressClinics = value;
                  });
                },
                initialValue: widget.data["address_waiting"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรอกที่อยู่คลินิก';
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
            Text('เวลา : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
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
                  setState(() {
                    _timeClinics = value;
                  });
                },
                initialValue: widget.data["time_waiting"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรอกเวลาทำการของคลินิก';
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
                  setState(() {
                    _detailClinics = value;
                  });
                },
                initialValue: widget.data["detail_waiting"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรอกรายละเอียดคลินิก';
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
                    // hintText: 'ชื่อคลินิก',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _tellClinics = value;
                    });
                  },
                  initialValue: widget.data["tell_waiting"],
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกเบอร์โทร';
                    } else if (value[0] != "0") {
                      return 'รูปแบบเบอร์โทรไม่ถูกต้อง';
                    } else if (value.length <= 9) {
                      return 'จำนวนเบอร์โทรไม่ถูกต้อง';
                    } else if (value.length > 10) {
                      return 'จำนวนเบอร์โทรไม่ถูกต้อง';
                    }
                    return null;
                  })),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildlatitude(double size) {
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
            Text('ค่าละติจูด : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
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
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) {
                  setState(() {
                    _latitudeClinics = value;
                  });
                },
                initialValue: widget.data["latitude_waiting"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรอกค่าละติจูด';
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

  Row buildlongitude(double size) {
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
            Text('ค่าลองจิจูด : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
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
                  // hintText: 'ชื่อคลินิก',
                ),
                onChanged: (value) {
                  setState(() {
                    _longitudeClinics = value;
                  });
                },
                initialValue: widget.data["longitude_waiting"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรอกค่าลองจิจูด';
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

  Row buildsearch(double size) {
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
            Text('อาการป่วย : ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'NotoSansThai')),
            Expanded(
              child: TextFormField(
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
                onChanged: (value) => _searchClinics = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'กรุณากรอกอาการป่วย';
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
                    isExpanded: false,
                    isDense: false,
                    // Must be one of items.value.
                    value: widget.data["type_waiting"].toString(),
                    hint: const Text('-----',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          widget.data["type_waiting"] = newValue;
                          _typeClinics = newValue;
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
                    value: widget.data["vehicle_waiting"].toString(),
                    hint: const Text('-----',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          widget.data["vehicle_waiting"] = newValue;
                          _vehicleclinics = newValue;
                        });
                      }
                    },
                    items: _dropDownMenuItems2,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  String _typeClinics = '-----';
  // ignore: unused_field
  String _vehicleclinics = '-----';

  static const menuItems = <String>[
    '-----',
    'สหคลินิก',
    'คลินิกสัตว์',
    'กุมารเวชกรรม',
    'ทันตกรรม',
    'พยาบาลและการผดุงครรค์',
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
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(124, 185, 163, 1),
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
              return BarAdminScreen(
                index: 2,
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
            Text("ทำการอนุมัติคลินิก",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'NotoSansThai')),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imagePath != null
                    ? Container(
                        height: 180,
                        width: 200,
                        child: Image.file(File(imagePath!.path)))
                    : Container(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          "${widget.data["img_waiting"].toString()}",
                          height: 150,
                          width: 190,
                        ),
                      ),
                IconButton(
                    icon: SizedBox(
                      height: 100,
                      child: Image.asset("images/bog.png"),
                    ),
                    iconSize: 50.0,
                    onPressed: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        imagePath = image!;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 10,
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
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            buildTime(size),
            SizedBox(
              height: 10,
            ),

            builddetail(size),
            SizedBox(
              height: 10,
            ),
            buildcar(size),

            ///
            SizedBox(
              height: 10,
            ),
            buildlatitude(size),
            SizedBox(
              height: 10,
            ),
            buildlongitude(size),
            SizedBox(
              height: 10,
            ),

            buildsearch(size),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCreatClinic(context),
                buildCreatnoClinic(context)
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ])),
        ),
      ),
    );
  }

  AnimatedButton buildCreatClinic(context) {
    return AnimatedButton(
      color: Color.fromRGBO(251, 182, 6, 1),
      width: 180,
      height: 60,
      onPressed: () async {
        print("fdgdfg");
        print(_nameClinics);
        if (formKey.currentState!.validate()) {
          final dataClinicadmin = await api2.doClinicadmin(
              widget.data["id_waiting"].toString(),
              _nameClinics,
              _addressClinics,
              _tellClinics,
              _imgClinics,
              _timeClinics,
              _typeClinics,
              _detailClinics,
              _vehicleclinics,
              _latitudeClinics,
              _longitudeClinics,
              imagePath,
              _imgoldClinics,
              _searchClinics);
          print(dataClinicadmin);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BarAdminScreen(
              index: 2,
            );
          }));
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Image.asset(
                            "images/green.png",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("ทำการอนุมัติเรียบร้อยเเล้ว",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'NotoSansThai')),
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: Text('อนุมัติ',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'NotoSansThai')),
    );
  }

  AnimatedButton buildCreatnoClinic(context) {
    return AnimatedButton(
      color: Color.fromRGBO(251, 182, 6, 1),
      width: 180,
      height: 60,
      onPressed: () {
        deleteawaiting(widget.data["id_waiting"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BarAdminScreen(
            index: 2,
          );
        }));
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Image.asset(
                          "images/red.png",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("ทำการไม่อนุมัติเรียบร้อยเเล้ว",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'NotoSansThai')),
                    ],
                  ),
                ),
              );
            });
      },
      child: Text('ไม่อนุมัติ',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'NotoSansThai')),
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 48, 48),
          width: 3,
        ));
  }

  Future<void> deleteawaiting(dynamic data) async {
    String path = "${Config.url}/deleteclinicsawaiting";
    print(data);
    var res = await Dio()
        .delete(path, data: {"id_waiting": widget.data["id_waiting"]});
    var resJson = json.decode(res.toString());
    getClinicawait();
    print(resJson);
    setState(() {
      getClinicawait();
    });
  }
}

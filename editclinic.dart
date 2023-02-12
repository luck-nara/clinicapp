import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/admin/crud.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/api/apiclinicwaiting.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:clinicapp/screen/widgets/show_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../utility/add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: avoid_web_libraries_in_flutter

import '../api/apiclinicwaiting.dart';

class EditclinicScreen extends StatefulWidget {
  const EditclinicScreen({Key? key, required Text title, required this.data})
      : super(key: key);
  final data;
  @override
  _EditclinicScreenState createState() => _EditclinicScreenState();
}

class _EditclinicScreenState extends State<EditclinicScreen> {
  // ignore: unused_field
  // ignore: unused_field
  String _nameClinics = "";
  // ignore: unused_field
  String _addressClinics = "";
  // ignore: unused_field
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
  // ignore: unused_field
  String _searchClinics = "";

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
  // ignore: unused_field
  TextEditingController _ctrlSearchClinics = TextEditingController();

  final formKey3 = GlobalKey<FormState>();
  var _data;
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();

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
  String _btn1SelectedVal = 'สหคลินิก';
  // ignore: unused_field
  String _btn2SelectedVal = 'รถทุกชนิด';
  static const menuItems = <String>[
    'สหคลินิก',
    'คลินิกสัตว์',
    'กุมารเวชกรรม',
    'ทันตกรรม',
    'การพยาบาลและการผดุงครรค์',
    'ศัลยกรรมกระดูกและข้อ',
    'กายยภาพบำบัด',
    'เทคนิคการแพทย์',
    'การแพทย์แผนไทย',
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
          child: Text(value),
        ),
      )
      .toList();

  void initState() {
    super.initState();
    setState(() {
      _nameClinics = widget.data["name_clinics"];
      // ignore: unused_field
      _addressClinics = widget.data["address_clinics"];

      // ignore: unused_field
      _tellClinics = widget.data["tell_clinics"];

      // ignore: unused_field
      _imgClinics = widget.data["img_clinics"];
      // ignore: unused_field
      _timeClinics = widget.data["time_clinics"];
      // ignore: unused_field
      _btn1SelectedVal = widget.data["type_clinics"];
      // ignore: unused_field
      _detailClinics = widget.data["detail_clinics"];
      // ignore: unused_field
      _btn2SelectedVal = widget.data["vehicle_clinics"];
      // ignore: unused_field
      _latitudeClinics = widget.data["latitude_clinics"];
      _longitudeClinics = widget.data["longitude_clinics"];
      // ignore: unused_fiel
      _searchClinics = widget.data["search_clinics"];
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
                onChanged: (value) => _nameClinics = value,
                initialValue: widget.data["name_clinics"],
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
                onChanged: (value) => _addressClinics = value,
                initialValue: widget.data["address_clinics"],
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
                  onChanged: (value) => _tellClinics = value,
                  initialValue: widget.data["tell_clinics"],
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกเบอร์โทร';
                    } else if (value[0] != "0") {
                      return 'รูปแบบเบอร์โทรไม่ถูกต้อง';
                    } else if (value.length != 10) {
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
                onChanged: (value) => _timeClinics = value,
                initialValue: widget.data["time_clinics"],
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
                onChanged: (value) => _latitudeClinics = value,
                initialValue: widget.data["latitude_clinics"],
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildimg(double size) {
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
                onChanged: (value) => _longitudeClinics = value,
                initialValue: widget.data["longitude_clinics"],
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
                onChanged: (value) => _detailClinics = value,
                initialValue: widget.data["detail_clinics"],
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Future<void> getClinic() async {
    String path = "${Config.url}/getclinic";
    var data;

    await Dio().get(path).then((value) => data = value);
    data = json.decode(data.toString());
    //print(_data);

    setState(() {
      _data = data["data"];
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imagePath != null
                    ? Container(
                        width: 150,
                        height: 150,
                        child: Image.file(File(imagePath!.path)))
                    : Container(
                        width: 150,
                        height: 150,
                        child: Image.network(
                          "${widget.data["img_clinics"].toString()}",
                        ),
                      ),
                IconButton(
                    icon: SizedBox(
                      height: 50,
                      child: Image.asset("images/5972923.png"),
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
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text('ประเภท : ',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai')),
                Container(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  height: 60,
                  width: 265,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    /*border: Border.all(
                    color: Color.fromRGBO(251, 182, 6, 1),
                    width: 3,
                  ),*/
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: ListTile(
                    //title: const Text('ประเภทคลินิก  :'),
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // Must be one of items.value.
                        value: _btn1SelectedVal,
                        hint: const Text('1',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => _btn1SelectedVal = newValue);
                          }
                        },
                        items: this._dropDownMenuItems,
                      ),
                    ),
                  ),
                ),
              ],
            ),

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
            buildTime(size),
            SizedBox(
              height: 10,
            ),
            builddetail(size),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text('รถที่สะดวก : ',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai')),
                Container(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  height: 60,
                  width: 245,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    /*border: Border.all(
                          color: Color.fromRGBO(251, 182, 6, 1), width: 3),*/
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: ListTile(
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _btn2SelectedVal,
                        hint: const Text('1',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => _btn2SelectedVal = newValue);
                          }
                        },
                        items: this._dropDownMenuItems2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //buildvehicle(size),,
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
                      initialValue: widget.data["search_clinics"],
                    ),
                  ),
                ],
              ),
            ),
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
                  print(_nameClinics);
                  var res = await Dio().put("${Config.url}/editclinic", data: {
                    "name_clinics": _nameClinics,
                    "address_clinics": _addressClinics,
                    "tell_clinics": _tellClinics,
                    "time_clinics": _timeClinics,
                    "type_clinics": _btn1SelectedVal,
                    "detail_clinics": _detailClinics,
                    "vehicle_clinics": _btn2SelectedVal,
                    "latitude_clinics": _latitudeClinics,
                    "longitude_clinics": _longitudeClinics,
                    "search_clinics": _searchClinics,
                    "img_clinics": imagePath,
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
                },
                child: Text("บันทึก"),
              ),
            ],
          ),
        );
      },
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

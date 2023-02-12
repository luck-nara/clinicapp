// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/admin/approve.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:clinicapp/admin/crud.dart';
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
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
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
      )
    ]);
  }

  Row buildAddresse(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: ("ที่อยู่คลินิก"),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          initialValue: widget.data["address_waiting"],
          onChanged: (value) => _addressClinics = value,
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

  Row buildTime(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: ("เวลาเปิด-ปิด"),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          initialValue: widget.data["time_waiting"],
          onChanged: (value) => _timeClinics = value,
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

  Row builddetail(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: ("เวลาเปิด-ปิด"),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          initialValue: widget.data["detail_waiting"],
          onChanged: (value) => _detailClinics = value,
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรอกรายละเอียดคลินิก';
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
            //labelText: ("เบอร์โทรคลินิก"),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          initialValue: widget.data["tell_waiting"],
          onChanged: (value) => _tellClinics = value,
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

  Row buildImg(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 370,
        height: 70,
        child: TextFormField(
          decoration: new InputDecoration(
            //labelText: ("ลิงค์รูปภาพ"),
            border: myinputborder(),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          onChanged: (value) => _imgClinics = value,
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

  Row buildlatitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 180,
        height: 70,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: new InputDecoration(
            //labelText: ('ค่าละติจูด'),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          initialValue: widget.data["latitude_waiting"],
          onChanged: (value) => _latitudeClinics = value,
        ),
      )
    ]);
  }

  Row buildlongitude(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 180,
        height: 70,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: new InputDecoration(
            //labelText: ('ค่าลองติจูด'),
            enabledBorder: myinputborder(),
            focusedBorder: myfocusborder(),
            filled: true, //<-- SEE HERE
            fillColor: Color.fromARGB(255, 255, 255, 255),
          ),
          initialValue: widget.data["longitude_waiting"],
          onChanged: (value) => _longitudeClinics = value,
        ),
      )
    ]);
  }

  String _typeClinics = 'สหคลินิก';
  // ignore: unused_field
  String _vehicleclinics = 'รถทุกชนิด';

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
    'กิจกรรมบำบัด'
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
      backgroundColor: Color.fromARGB(255, 170, 170, 170),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            {
              Navigator.pop(context);
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(children: [
            Text("ทำการอนุมัติคลินิก"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('ชื่อคลินิกvb',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
            buildName(size),
            SizedBox(
              height: 0,
            ),
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
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: false,
                    isDense: false,
                    // Must be one of items.value.
                    value: widget.data["type_waiting"].toString(),
                    hint: const Text('1',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _typeClinics = newValue);
                      }
                    },
                    items: this._dropDownMenuItems,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
            SizedBox(
              height: 5,
            ),
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
            SizedBox(
              height: 5,
            ),
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
            SizedBox(
              height: 5,
            ),
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
            builddetail(size),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('แนะนำรถที่สะดวกต่อการจอดรถ',
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
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _vehicleclinics,
                    /* hint: const Text('รถทุกชนิด',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),*/
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _vehicleclinics = newValue);
                      }
                    },
                    items: _dropDownMenuItems2,
                  ),
                ),
              ),
            ),

            ///
            SizedBox(
              height: 5,
            ),
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
            TextFormField(
              decoration: new InputDecoration(
                //labelText: ("เวลาเปิด-ปิด"),
                border: myinputborder(),
                enabledBorder: myinputborder(),
                focusedBorder: myfocusborder(),
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
              ),
              onChanged: (value) => _searchClinics = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'กรอกเวลา';
                }
                return null;
              },
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('รูปภาพ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCreatClinic(context),
                buildCreatnoClinic(context)
              ],
            ),
          ])),
        ),
      ),
    );
  }

  AnimatedButton buildCreatClinic(context) {
    return AnimatedButton(
      color: Color.fromRGBO(79, 101, 93, 1),
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
            return CrudScreen();
          }));
        }
      },
      child: Text(
        'บันทึกข้อมูล',
        style: TextStyle(fontSize: 25, color: Color.fromRGBO(251, 182, 6, 1)),
      ),
    );
  }

  AnimatedButton buildCreatnoClinic(context) {
    return AnimatedButton(
      color: Color.fromRGBO(79, 101, 93, 1),
      width: 180,
      height: 60,
      onPressed: () {
        print(widget.data);
        deleteawaiting(widget.data["id_waiting"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ApproveScreen();
        }));
      },
      child: Text(
        'ไม่อนุมัติ',
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
//มึงดึงตัวแปรไม่ถูกอะ ลองปริ้นก่อนว่าข้อมูลมันมาแบบไหนอะ กุเอา 2 ตารางมาผสมกันอ้ะ กุไม่รุ้จะอุนมัติเเบบไหนมึงลองดูดิ
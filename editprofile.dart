import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/api/api.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/add.dart';
import '../index.dart';
import '../wellcome.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, this.data}) : super(key: key);
  final data;
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // ignore: unused_field
  String _firstnameMember = "";
  // ignore: unused_field
  String _lastnameMember = "";

  // ignore: unused_field
  String _tellMember = "";

  // ignore: unused_field
  String _usernameMember = "";
  // ignore: unused_field
  String _passwordMember = "";

  ApiProvider api5 = ApiProvider();

  // ignore: unused_field
  TextEditingController _ctrlFirstnameMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlLastnameMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlTellMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlUsernameMember = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlPasswordMember = TextEditingController();

  final formKey5 = GlobalKey<FormState>();
  void initState() {
    super.initState();
    print(User.userData);
    setState(() {
      _firstnameMember = User.userData["firstname_member"];
      // ignore: unused_field
      _lastnameMember = User.userData["lastname_member"];

      // ignore: unused_field
      _tellMember = User.userData["tell_member"];

      // ignore: unused_field
      _usernameMember = User.userData["username_member"];

      _passwordMember = User.userData["password_member"];
      // ignore: unused_field
    });
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
              return ProfileScreen();
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text('แก้ไขโปรไฟล์',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSansThai')),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("images/profile2.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 50,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(251, 182, 6, 1),
                ),
                child: TextFormField(
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _usernameMember = value,
                  initialValue: User.userData["username_member"],
                ),
                //TextFormField(initialValue: User.userData["username_member"]),
              ),
              SizedBox(
                height: 10,
              ),
              Text("ชื่อผู้ใช้",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'NotoSansThai')),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('ชื่อจริง : ',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'NotoSansThai')),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 350,
                    height: 50,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _firstnameMember = value,
                      initialValue: User.userData["firstname_member"],
                    ),
                    //TextFormField(initialValue: User.userData["username_member"]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('นามสกุล : ',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'NotoSansThai')),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 350,
                    height: 50,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _lastnameMember = value,
                      initialValue: User.userData["lastname_member"],
                    ),
                    //TextFormField(initialValue: User.userData["username_member"]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('เบอร์โทร : ',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'NotoSansThai')),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 350,
                    height: 50,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _tellMember = value,
                      initialValue: User.userData["tell_member"],
                    ),
                    //TextFormField(initialValue: User.userData["username_member"]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('รหัสผ่าน : ',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'NotoSansThai')),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 350,
                    height: 50,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _passwordMember = value,
                      initialValue: User.userData["password_member"],
                    ),
                    //TextFormField(initialValue: User.userData["username_member"]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              saveeditButton(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveeditButton() => Container(
        child: AnimatedButton(
          width: 200,
          height: 60,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            print(_usernameMember);
            print(_firstnameMember);
            var res = await Dio().put("${Config.url}/editmember", data: {
              "firstname_member": _firstnameMember,
              "lastname_member": _lastnameMember,
              "tell_member": _tellMember,
              "username_member": _usernameMember,
              "password_member": _passwordMember,
              "id_member": User.userData["id_member"]
            });
            setState(() {
              User.userData["firstname_member"] = _firstnameMember;
              // ignore: unused_field

              User.userData["lastname_member"] = _lastnameMember;

              // ignore: unused_field
              User.userData["tell_member"] = _tellMember;

              // ignore: unused_field

              User.userData["username_member"] = _usernameMember;

              User.userData["password_member"] = _passwordMember;
            });
            var resJson = json.decode(res.toString());
            print(resJson);
            // Navigator.pop(context);

            await Navigator.push(
              context(),
              CupertinoPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
            ScaffoldMessenger.of(context()).showSnackBar(
                SnackBar(content: Text("แก้ไขข้อมูลโปรไฟล์เรียบร้อยเเล้ว")));
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
}

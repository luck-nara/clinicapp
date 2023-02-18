import 'package:animated_button/animated_button.dart';
import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/profile/editprofile.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/add.dart';
import '../index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("กดเกดเ");
    print(User.userData);
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
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('โปรไฟล์',
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
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(251, 182, 6, 1),
                ),
                child: Text(User.userData["username_member"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansThai'))
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
            Container(
                width: 350,
                height: 50,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Text(User.userData["firstname_member"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai'))
                //TextFormField(initialValue: User.userData["username_member"]),
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
            Container(
                width: 350,
                height: 50,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Text(User.userData["lastname_member"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai'))
                //TextFormField(initialValue: User.userData["username_member"]),
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
            Container(
                width: 350,
                height: 50,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Text(User.userData["tell_member"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai'))
                //TextFormField(initialValue: User.userData["username_member"]),
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
            Container(
                width: 350,
                height: 50,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Text(User.userData["password_member"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'NotoSansThai'))
                //TextFormField(initialValue: User.userData["username_member"]),
                ),
            SizedBox(
              height: 10,
            ),
            editButton(),
            SizedBox(
              height: 10,
            ),
          ],
        )),
      ),
    );
  }

  Widget editButton() => Container(
        child: AnimatedButton(
          width: 250,
          height: 60,
          color: Color.fromRGBO(251, 182, 6, 1),
          onPressed: () async {
            Navigator.push(context(), MaterialPageRoute(builder: (context) {
              return EditProfileScreen();
            }));
          },
          child: Row(
            children: [
              SizedBox(
                  height: 30,
                  width: 60,
                  child: Image.asset("images/edit2.png")),
              Text(
                'แก้ไขโปรไฟล์',
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

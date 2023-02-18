import 'package:clinicapp/admin/add.dart';
import 'package:clinicapp/admin/approve.dart';
import 'package:clinicapp/admin/indexadmin.dart';
import 'package:clinicapp/admin/loginadmin.dart';
import 'package:clinicapp/screen/alert.dart';
import 'package:clinicapp/screen/comment.dart';
import 'package:clinicapp/screen/dataclinic.dart';
import 'package:clinicapp/screen/date.dart';
import 'package:clinicapp/screen/index2.dart';
import 'package:clinicapp/screen/login.dart';
import 'package:clinicapp/screen/profile/profile.dart';
import 'package:clinicapp/screen/search/search.dart';
import 'package:clinicapp/screen/search/searchcsick.dart';
import 'package:clinicapp/screen/search/searchdisease.dart';
import 'package:clinicapp/screen/search/searchdistrict.dart';
import 'package:clinicapp/screen/search/searchname.dart';
import 'package:clinicapp/screen/setting.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utility/add.dart';

// ignore: must_be_immutable
class BarAdminScreen extends StatefulWidget {
  BarAdminScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  int? index;
  @override
  State<StatefulWidget> createState() {
    return _BarAdminScreenState();
  }
}

class _BarAdminScreenState extends State<BarAdminScreen> {
  int _selectedIndex = 0;
  dynamic? sda = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
    print("กกกกก");
  }

  Future<void> test() async {
    final test = await Dio().get("${Config.url}/getwarn");
    print("wwww");
    print(test.data);
    setState(() {
      sda = test.data["data"][0]["read_warn"];
      print("กกกกก");
      print(sda);
    });
  }

  final List<Widget> _pageWidget = <Widget>[
    IndexadminScreen(),
    AddScreen(),
    ApproveScreen(),
  ];
  var a = 1;
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: SizedBox(
          height: 30, width: 60, child: Image.asset("images/home.png")),
      label: 'หน้าหลัก',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
          height: 30, width: 60, child: Image.asset("images/addclinic.png")),
      label: 'เพิ่มคลินิก',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
          height: 30, width: 60, child: Image.asset("images/approve.png")),
      label: 'คลินิกรออนุมัติ',
    ),
  ];

  void _onItemTapped(int index) {
    print(index);
    widget.index = null;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("1111111111");
    print(widget.index);
    print("22222222222");
    print(_selectedIndex);

    return Scaffold(
      body: _pageWidget.elementAt(widget.index ?? _selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 10, 81, 3),
          items: _menuBar,
          iconSize: 40,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

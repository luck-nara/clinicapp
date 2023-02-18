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
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'creatclinic/addclinic.dart';
import 'index.dart';

// ignore: must_be_immutable
class BarScreen extends StatefulWidget {
  BarScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  int? index;
  @override
  State<StatefulWidget> createState() {
    return _BarScreenState();
  }
}

class _BarScreenState extends State<BarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pageWidget = <Widget>[
    IndexScreen(
      data: null,
      title: Text(""),
    ),
    AddclinicScreen(
      data: null,
    ),
    DateScreen(),
    AlertScreen(),
    DataclinicScreen(
      data: null,
      title: Text(""),
    ),
    Index2Screen(),
    SearchScreen(),
    SearchnameScreen(),
    SearchsickScreen(),
    SearchdiseaseScreen(),
    SearchdistrictScreen(),
    CommentScreen(
      idClinics: null,
    ),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
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
          height: 30, width: 60, child: Image.asset("images/note.png")),
      label: 'นัดหมาย',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
          height: 30, width: 60, child: Image.asset("images/ring.png")),
      label: 'แจ้งเตือน',
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

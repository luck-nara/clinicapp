import 'package:clinicapp/screen/Bar.dart';
import 'package:clinicapp/screen/search/searchcsick.dart';
import 'package:clinicapp/screen/search/searchname.dart';
import 'package:clinicapp/screen/wellcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0), //ซ้าย,บน,ขวา,ล่าง
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BarScreen(
                    index: 7,
                  );
                }));
              },
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 0,
                    )
                  ],
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 150,
                      width: 50,
                      child: Image.asset("images/3027324.png")),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('ค้นหาคลินิกตามรายชื่อคลินิก',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansThai')),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0), //ซ้าย,บน,ขวา,ล่าง
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BarScreen(index: 8);
                }));
              },
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 0,
                    )
                  ],
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 150,
                      width: 50,
                      child: Image.asset("images/sick.png")),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('ค้นหาคลินิกตามอาการ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansThai')),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0), //ซ้าย,บน,ขวา,ล่าง
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BarScreen(
                    index: 9,
                  );
                }));
              },
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 0,
                    )
                  ],
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 150,
                      width: 50,
                      child: Image.asset("images/sepo.png")),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('ค้นหาคลินิกตามโรคเฉพาะทาง',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansThai')),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0), //ซ้าย,บน,ขวา,ล่าง
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BarScreen(
                    index: 10,
                  );
                }));
              },
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 0,
                    )
                  ],
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 150,
                      width: 50,
                      child: Image.asset("images/tembon.png")),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('ค้นหาคลินิกตามตำบล',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansThai')),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

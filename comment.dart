import 'dart:convert';

import 'package:clinicapp/api/apicomment.dart';
import 'package:clinicapp/screen/dataclinic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../utility/add.dart';
import 'wellcome.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.idClinics}) : super(key: key);
  final idClinics;
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController textarea = TextEditingController();

  // ignore: unused_field
  String _idclinicComment = "";
  // ignore: unused_field
  int _starComment = 0;
  // ignore: unused_field
  String _detailComment = "";
  // ignore: unused_field
  String _idmemberComment = "";

  ApiProvidercomment api6 = ApiProvidercomment();

  // ignore: unused_field
  TextEditingController _ctrlIdclinicComment = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlStartComment = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlDetailCommet = TextEditingController();

  // ignore: unused_field
  TextEditingController _ctrlIdmemberComment = TextEditingController();

  // ignore: unused_field
  final _formKey6 = GlobalKey<FormState>();

  var _data;
  var _dataUser;
  Map<String, String> _nameUser = {};
  Future<void> getComments() async {
    String path = "${Config.url}/getcomments";
    String pathUser = "${Config.url}/getmember";

    var datacomment;
    await Dio().get(path).then((value) => {datacomment = value});

    var dataUsert;
    await Dio().get(pathUser).then((value) => {dataUsert = value});
    datacomment = json.decode(datacomment.toString());
    dataUsert = json.decode(dataUsert.toString());
    print("กดเกดเกดเ");
    // print(dataUsert);
    Map<String, String> nameUser = {};
    for (int i = 0; i < dataUsert["data"].length; i++) {
      nameUser[dataUsert["data"][i]["id_member"].toString()] =
          dataUsert["data"][i]["username_member"].toString();
      print(dataUsert["data"][i]["username_member"]);
    }
    print(nameUser);
    setState(() {
      _data = datacomment["data"];
      _dataUser = dataUsert["data"];
      _nameUser = nameUser;
    });
  }

  double value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(User.userData);
    print(widget.idClinics);
    getComments();
    _idclinicComment = widget.idClinics.toString();
    _idmemberComment = User.userData["id_member"].toString();
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
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('แสดงความคิดเห็น',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansThai')),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(3, 60, 39, 1),
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  RatingStars(
                    value: value,
                    onValueChanged: (v) {
                      //
                      setState(() {
                        value = v;
                        _starComment = v.toInt();
                        print(_starComment);
                        print(v);
                      });
                    },
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                    ),
                    starCount: 5,
                    starSize: 20,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 1,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: Duration(milliseconds: 1000),
                    valueLabelPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 350,
                    height: 70,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: textarea,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        hintText: 'แสดงความคิดเห็น',
                      ),
                      onChanged: (value) => _detailComment = value,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("เเเเเเเเเเเเเเเ");
                      print(_starComment);
                      final dataUser = await api6.doComment(
                        _idclinicComment ?? "",
                        _starComment,
                        _detailComment ?? "",
                        _idmemberComment ?? "",
                      );
                      print(dataUser);
                      /*
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CommentScreen(
                          idClinics: widget.idClinics,
                        );
                      }));
                      */
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("แสดงความคิดเห็นเรียบร้อยเเล้ว")));
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(251, 182, 6, 1),
                            Color.fromRGBO(251, 182, 6, 1)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 50,
                                  child: Image.asset("images/comment.png")),
                              Text("ส่งความคิดเห็น",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NotoSansThai')),
                            ],
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: (_data != null)
                    ? FutureBuilder(builder: (context, snapshot) {
                        return ListView.separated(
                          itemBuilder: (context, i) {
                            if (widget.idClinics.toString() ==
                                _data[i]["id_clinics"].toString()) {
                              return ListTile(
                                title: Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  _nameUser[_data[i]
                                                              ["id_member"]
                                                          .toString()]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontSize: 16,
                                                      /*fontWeight:
                                                                            FontWeight.bold,*/
                                                      fontFamily:
                                                          'NotoSansThai')),
                                              Wrap(
                                                  spacing:
                                                      12, // space between two icons
                                                  children: <Widget>[
                                                    for (int j = 0;
                                                        j <=
                                                            _data[i][
                                                                    "star_comment"] -
                                                                1;
                                                        j++)
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                  ]),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "${_data[i]["detail_comment"].toString()}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontSize: 20,
                                                  /*fontWeight:
                                                                        FontWeight.bold,*/
                                                  fontFamily: 'NotoSansThai')),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                          separatorBuilder: (context, i) {
                            return Container();
                          },
                          itemCount: _data?.length ?? 0,
                        );
                      })
                    : Center(
                        child: CircularProgressIndicator(),
                      ))
          ],
          //Text(widget.data["name"]),
        ),
      ),
    );
  }
}

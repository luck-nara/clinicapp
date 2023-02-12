import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'creatclinic/map_clinic.dart';

class AeScreen extends StatefulWidget {
  const AeScreen({
    Key? key,
    required this.data,
  }) : super(key: key);
  final data;
  @override
  _AeScreenState createState() => _AeScreenState();
}

class _AeScreenState extends State<AeScreen> {
  var _data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("จำลองดึงข้อมูล"),
        backgroundColor: Colors.green[700],
      ),
      body: Column(children: [
        Text(widget.data["lat"].toString()),
        Text(widget.data["lng"].toString()),
        TextButton(
          child: const Text(
            'สมัครสมาชิก?    ',
            style:
                TextStyle(fontSize: 20, color: Color.fromARGB(255, 10, 10, 10)),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MapclinicScreen();
            })).then((value) {
              print("lat");
            });
          },
        ),
      ]),
    );
  }
}

import 'package:clinicapp/model/usermodel.dart';
// ignore: unused_import
import 'package:clinicapp/model/adminmodel.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'dart:io';
import 'dart:async';

import '../utility/add.dart';

class ApiProviderappoint {
  Future<dynamic> doAppoint(String dateAppoint, String detailAppoint,
      String nameclinicsAppoint, String idmemberAppoint) async {
    // ignore: unused_local_variable
    final api7 = '${Config.url}/addappoint';

    //print(idclinicComment + startComment + detailCommet + idmemberComment);

    // ignore: unused_local_variable
    final data = {
      "date_appoint": dateAppoint,
      "detail_appoint": detailAppoint,
      "name_clinics": nameclinicsAppoint,
      "id_member": idmemberAppoint,
    };
    print(data);
    // ignore: unused_local_variable
    try {
      final dio = Dio();
      print("0000");
      Response response;
      response = await dio.post(api7, data: data);
      print(response.data);
      final dataAppoint = response.data;
      print(dataAppoint);

      if (dataAppoint["detail_appoint"] != null) {
        return dataAppoint;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }
}

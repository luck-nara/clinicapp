// ignore: unused_import
import 'package:clinicapp/model/usermodel.dart';
import 'package:clinicapp/utility/add.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'dart:ui';
import 'dart:async';
// ignore: unused_import
import '../model/clinicmodel.dart';

class ApiProviders {
  //เพิ่มคลินิกผู้ใช้งาน
  Future<dynamic> doClinicuser(
      String nameWaiting,
      String addressWaiting,
      String tellWaiting,
      String timeWaiting,
      String typeWaiting,
      String vehicleWaiting,
      String latitudeWaiting,
      String longitudeWaiting,
      String detailWaiting,
      dynamic image,
      String _imgoldClinics) async {
    // ignore: unused_local_variable
    final api4 = '${Config.url}/creatclinicuser';
    print("กดเกดเ");
    // ignore: unused_local_variable
    /**/
    // ignore: unused_local_variable
    try {
      final dio = Dio();
      Response response;
      var responseImage;
      try {
        final formData = FormData.fromMap({
          "files":
              await MultipartFile.fromFile(image.path!, filename: image.name),
        });
        final test =
            await dio.post('${Config.urlUploadImage}/upload', data: formData);
        print(test.data);
        responseImage = test.data.substring(1, test.data.length - 1);
      } catch (err) {
        responseImage = _imgoldClinics;
      }
      print(responseImage);
      final data = {
        "name_waiting": nameWaiting,
        "address_waiting": addressWaiting,
        "tell_waiting": tellWaiting,
        "time_waiting": timeWaiting,
        "type_waiting": typeWaiting,
        "vehicle_waiting": vehicleWaiting,
        "latitude_waiting": latitudeWaiting,
        "longitude_waiting": longitudeWaiting,
        "detail_waiting": detailWaiting,
        "img_waiting": responseImage.toString(),
      };
      response = await dio.post(api4, data: data);
      final dataClinicuser = response.data;
      print(dataClinicuser);

      if (dataClinicuser["name_waiting"] != null) {
        return dataClinicuser;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }

  Future putClinic(
      String nameWaiting,
      String addressWaiting,
      String tellWaiting,
      String timeWaiting,
      String typeWaiting,
      String detailWaiting,
      String vehicleWaiting,
      String latitudeWaiting,
      String longitudeWaiting) async {
    // ignore: unused_local_variable
    final api3 = '${Config.url}/editclinic';

    print(nameWaiting +
        addressWaiting +
        tellWaiting +
        timeWaiting +
        typeWaiting +
        detailWaiting +
        vehicleWaiting +
        latitudeWaiting +
        longitudeWaiting);

    print("11111111111111111111111111");
    // ignore: unused_local_variable
    final data = {
      "name_waiting": nameWaiting,
      "address_waiting": addressWaiting,
      "tell_waiting": tellWaiting,
      "time_waiting": timeWaiting,
      "type_waiting": typeWaiting,
      "vehicle_waiting": vehicleWaiting,
      "latitude_waiting": latitudeWaiting,
      "longitude_waiting": longitudeWaiting
    };
    // ignore: unused_local_variable
    try {
      final dio = Dio();
      Response response;
      response = await dio.put(api3, data: data);

      final dataClinic = response.data;
      print(dataClinic);

      if (dataClinic["name_waiting"] != null) {
        return dataClinic;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }
}

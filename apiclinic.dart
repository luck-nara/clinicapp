// ignore: unused_import
import 'package:clinicapp/model/usermodel.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'dart:ui';
import 'dart:async';
// ignore: unused_import
import '../model/clinicmodel.dart';
import '../utility/add.dart';

class ApiProvidersadmin {
  // ignore: unused_element
  Future<dynamic> putClinic(
    int idClinics,
    String nameClinics,
    String addressClinics,
    String tellClinics,
    String imgClinics,
    String timeClinics,
    String typeClinics,
    String detailClinics,
    String vehicleClinics,
    String latitudeClinics,
    String longitudeClinics,
    dynamic image,
    String _imgoldClinics,
    String searchClinics,
  ) async {
    // ignore: unused_local_variable
    final api3 = '${Config.url}/editclinic';

    print(nameClinics +
        addressClinics +
        tellClinics +
        imgClinics +
        timeClinics +
        typeClinics +
        detailClinics +
        vehicleClinics +
        latitudeClinics +
        longitudeClinics +
        searchClinics);

    print("กดเกดเ");
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
        "id_clinics": idClinics,
        "name_clinics": nameClinics,
        "address_clinics": addressClinics,
        "tell_clinics": tellClinics,
        "img_clinics": responseImage.toString(),
        "time_clinics": timeClinics,
        "type_clinics": typeClinics,
        "detail_clinics": detailClinics,
        "vehicle_clinics": vehicleClinics,
        "latitude_clinics": latitudeClinics,
        "longitude_clinics": longitudeClinics,
        "search_clinics": searchClinics
      };
      print(responseImage.toString());
      print("ฟฟฟฟฟฟฟฟฟฟฟฟฟ");
      response = await dio.put(api3, data: data);

      print(response);
      final dataClinic = response.data;
      print(dataClinic);

      if (dataClinic["name_clinics"] != null) {
        return dataClinic;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }

  //เพิ่มคลินิกของแอดมิน
  Future<dynamic> doClinicadmin(
      String id,
      String nameClinics,
      String addressClinics,
      String tellClinics,
      String imgClinics,
      String timeClinics,
      String typeClinics,
      String detailClinics,
      String vehicleClinics,
      String latitudeClinics,
      String longitudeClinics,
      dynamic image,
      String _imgoldClinics,
      String searchClinics) async {
    // ignore: unused_local_variable
    final api2 = '${Config.url}/creatclinic';
    print("sdfsdfsdf");
    print(nameClinics +
        "\n" +
        addressClinics +
        "\n" +
        tellClinics +
        "\n" +
        imgClinics +
        "\n" +
        timeClinics +
        "\n" +
        typeClinics +
        "\n" +
        detailClinics +
        "\n" +
        vehicleClinics +
        "\n" +
        latitudeClinics +
        "\n" +
        longitudeClinics +
        "\n" +
        searchClinics);
    print(id);
    //delete
    String path = "${Config.url}/deleteclinicsawaiting";
    var res = await Dio().delete(path, data: {"id_waiting": id});
    print(res);
    print("กดเกดเ");
    print(image);
    // ignore: unused_local_variable

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
        "name_clinics": nameClinics,
        "address_clinics": addressClinics,
        "tell_clinics": tellClinics,
        "img_clinics": responseImage.toString(),
        "time_clinics": timeClinics,
        "type_clinics": typeClinics,
        "detail_clinics": detailClinics,
        "vehicle_clinics": vehicleClinics,
        "latitude_clinics": latitudeClinics,
        "longitude_clinics": longitudeClinics,
        "search_clinics": searchClinics
      };
      print("ฟฟฟฟฟฟฟฟฟฟฟฟฟ");
      response = await dio.post(api2, data: data);

      print(response);
      final dataClinicadmin = response.data;
      print(dataClinicadmin);

      if (dataClinicadmin["name_clinics"] != null) {
        return dataClinicadmin;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }
}

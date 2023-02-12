import 'package:clinicapp/model/usermodel.dart';
// ignore: unused_import
import 'package:clinicapp/model/adminmodel.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'dart:io';
import 'dart:async';
import '../utility/add.dart';

class ApiProvidercomment {
  Future<dynamic> doComment(String idclinicComment, int startComment,
      String detailCommet, String idmemberComment) async {
    // ignore: unused_local_variable
    final api6 = '${Config.url}/addcomments';

    //print(idclinicComment + startComment + detailCommet + idmemberComment);
    print(startComment);
    // ignore: unused_local_variable
    final data = {
      "id_clinics": idclinicComment,
      "star_comment": startComment,
      "detail_comment": detailCommet,
      "id_member": idmemberComment,
    };

    // ignore: unused_local_variable
    try {
      final dio = Dio();
      print("ดกดเ111111111111111");
      Response response;
      response = await dio.post(api6, data: data);
      print(response.data);
      final dataComment = response.data;
      print(dataComment);

      if (dataComment["id_member"] != null) {
        return dataComment;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }
}

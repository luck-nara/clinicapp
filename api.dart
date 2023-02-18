// ignore: unused_import
import 'package:clinicapp/model/usermodel.dart';
// ignore: unused_import
import 'package:clinicapp/model/adminmodel.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'dart:io';
import 'dart:async';

import '../utility/add.dart';
// ignore: unused_import
// ignore: unused_import

class ApiProvider {
  Future<dynamic> doLogin(String usernameMember, String passwordMember) async {
    // ignore: unused_local_variable
    final api = '${Config.url}/login';
    print(usernameMember + passwordMember);
    // ignore: unused_local_variable
    final data = {
      "username_member": usernameMember,
      "password_member": passwordMember
    };
    // ignore: unused_local_variable

    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);

    final dataUser = response.data;
    print(dataUser);

    if (dataUser["username_member"] != null) {
      return dataUser;
    } else {
      return null;
    }
  }

  Future<dynamic> doRegister(String firstnameMember, String lastnameMember,
      String tellMember, String usernameMember, String passwordMember) async {
    // ignore: unused_local_variable
    final api = '${Config.url}/register';

    print(firstnameMember +
        lastnameMember +
        tellMember +
        usernameMember +
        passwordMember);

    // ignore: unused_local_variable
    final data = {
      "firstname_member": firstnameMember,
      "lastname_member": lastnameMember,
      "username_member": usernameMember,
      "tell_member": tellMember,
      "password_member": passwordMember
    };
    // ignore: unused_local_variable
    try {
      final dio = Dio();
      Response response;
      response = await dio.post(api, data: data);

      final dataUser = response.data;
      print(dataUser);

      if (dataUser["username_member"] != null) {
        return dataUser;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }

  Future<dynamic> doLoginadmin(String userAdmin, String passwordAdmin) async {
    // ignore: unused_local_variable
    final String api3 = '${Config.url}/loginadmin';
    print(userAdmin + passwordAdmin);
    // ignore: unused_local_variable
    final data = {"user_admin": userAdmin, "password_admin": passwordAdmin};
    // ignore: unused_local_variable

    final dio = Dio();
    Response response;
    response = await dio.post(api3, data: data);

    final dataAdmin = response.data;
    print(dataAdmin);

    if (dataAdmin["user_admin"] != null) {
      return dataAdmin;
    } else {
      return null;
    }
  }

  Future putMember(
    String firstnameMember,
    String lastnameMember,
    String tellMember,
    String usernameMember,
    String passwordMember,
  ) async {
    // ignore: unused_local_variable
    final api5 = '${Config.url}/editmember';

    print(firstnameMember +
        lastnameMember +
        tellMember +
        usernameMember +
        passwordMember);

    print("กดเกดเ");
    // ignore: unused_local_variable
    final data = {
      "firstname_member": firstnameMember,
      "lastname_member": lastnameMember,
      "tell_member": tellMember,
      "username_member": usernameMember,
      "password_member": passwordMember
    };
    // ignore: unused_local_variable
    try {
      final dio = Dio();
      Response response;
      response = await dio.put(api5, data: data);

      final dataUser = response.data;
      print(dataUser);

      if (dataUser["username_member"] != null) {
        return dataUser;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxanimation/link_api.dart';
import 'package:getxanimation/serveces.dart';

class AuthController extends GetxController {
  Crud fun = Crud();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  RxBool isLoading = false.obs;

  // fun to clear texts after dispose
  clearTexts() {
    name.clear();
    phone.clear();
    pass.clear();
  }
  // future for login user
  Future login() async {
    Map data = {
      "name": name.text,
      "password": pass.text,
    };
    var response = await fun.postRequest(linkLogin, data);
    return response;
  }

  // future for register user
  Future register() async {
    Map data = {
      "name": name.text,
      "phone": phone.text,
      "pass": pass.text,
    };
    var response = await fun.postRequest(linkRigster, data);
    return response;
  }
}

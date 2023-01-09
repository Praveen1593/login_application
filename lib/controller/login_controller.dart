import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../main.dart';
import '../../network/api_controller.dart';
import '../model/loginresponse_model.dart';

import 'package:login_application/baseUtils/constants.dart';




class LoginController extends GetxController {
  var hasLoaderStart = false.obs;
  var isLoading = false.obs;

  Rx<LoginResponseModel> loginProfile = LoginResponseModel().obs;

  @override
  void onInit() {
    super.onInit();

  }


  Future<void> userloginAPI() async {
    var data = {
      'code': 'ST002',
      'password':'test78906'
    };
    hasLoaderStart.value = true;
    var res = await ApiController().loginPostAPICall(data);
    var jsonpar = json.decode(res);
    print('Response -> ${jsonpar['status']} * ${jsonpar['data']['username']}');

    preferences.setString(storeKey.userName.toShortString(),jsonpar['data']['username'].toString());
    preferences.setString(storeKey.id.toShortString(),jsonpar['data']['id'].toString());
    preferences.setString(storeKey.code.toShortString(),jsonpar['data']['code'].toString());
    preferences.setString(storeKey.email.toShortString(),jsonpar['data']['email'].toString());
    preferences.setString(storeKey.photo.toShortString(),jsonpar['data']['photo'].toString());
    preferences.setString(storeKey.phone.toShortString(),jsonpar['data']['phone'].toString());
    preferences.setString(storeKey.academic.toShortString(),jsonpar['data']['academic_id'].toString());
    preferences.setString(storeKey.message.toShortString(),jsonpar['data']['message'].toString());

    hasLoaderStart.value = false;

    if( res != null ){
      loginProfile.value = LoginResponseModel.fromJson(jsonpar['data']);
    }else if( res == null ){
      Get.snackbar(res['status'].toString(), res['message'].toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red[400], colorText: Colors.white);
    }
  }
}

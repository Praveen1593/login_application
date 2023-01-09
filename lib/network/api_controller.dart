
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'app_exception.dart';
import 'package:http/http.dart' as http;

class ApiController{
  static var client = http.Client();
  String base_url = 'https://test.schoolec.in/api/staff/v2/';

  Future<http.Response> networkCall(url, body) async {
    var client = http.Client();
    try {
      var urlParse = Uri.parse("${base_url}"+url);
      print('API Call -> ${urlParse} \n ${body}');
      var response = await http.post(urlParse, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    }catch(e){

      throw ('Error en el POST -${e}');
    } finally {
      client.close();
    }
  }
  Future<http.Response> getNetworkCall( url, Map<dynamic, dynamic> queryParam) async {
    String? token;

 //   token = preferences.getString('${storeKey.token.toShortString()}');

    var client = http.Client();
    try {
      String queryStr  = "";
      int i = 0 ;
      if( queryParam != null ){
        print('Find 1 -> ${queryParam}');
        queryParam.forEach((key, value) {
          if( i == 0 )
            queryStr += '?${key}=$value';
          else
            queryStr += '&${key}=$value';
          i++;
        });
      }
      var urlParse = Uri.parse('${base_url}$url$queryStr');
      print('Get URL - > ${urlParse}');
      var response = await http.get(urlParse,headers: {'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      }
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    }catch(e){

      throw ('Error en el POST${e}');
    } finally {
      client.close();
    }
  }



  dynamic loginPostAPICall(data)async{
    try {
      dynamic responseJson;
      http.Response res = await networkCall('login',data);
      responseJson = returnResponse(res);
      return responseJson;
    } on SocketException {
      print('API Error->');
      throw FetchDataException('No Internet Connection');
    }

  }



}

dynamic returnResponse(http.Response response) async {
  print('API Status Code-> ${response.statusCode}');
  if( response.body != null && response.body.isNotEmpty){
    print('API res-> ${response.body}');
    if( response.body != null && response.body.toString() != 'null' && response.body.toString().trim() != ""){
      //var temp = json.decode(response.body);
      String jsonsDataString = response.body.toString();
      final jsonData = jsonDecode(jsonsDataString);
      //print('API res JSON -> ${jsonData}');
      if( jsonData['authentication'] == 'fail' ){
        //GlobalDetails.reset();
        //await preferences.clear();
        Get.snackbar('Error', 'You are already logged in another Device', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red[400], duration: Duration(seconds: 5), colorText: Colors.white );

        return null;
      }
    }
  }
  switch (response.statusCode) {
    case 200:
      return response.body;
    case 302:
      return response.body;
    case 404:
      Get.snackbar(
          'Failed',
          '${response.body}',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red[400],
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white
      );
      return null;
    default:
      throw FetchDataException(
          'Error occured while communication with server' +
              ' with status code : ${response.statusCode}');
  }
}


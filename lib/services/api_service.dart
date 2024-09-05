import 'dart:convert';

import 'package:ekisan_credit/services/toast_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preference_helper.dart';

class ApiService {
  String baseUrl = 'http://13.232.66.157:8080/api/loan/master';
  String newBaseUrl = 'http://13.232.66.157:8080/api';

  // Future<List<String>?> getToken2() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     List<String>? token = prefs.getStringList('token');
  //     return token;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error getting token: $e');
  //     }
  //     return null;
  //   }
  // }
  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('token');
  }

  Future<http.Response> apiCall(String endPoint,
      {Map<String, dynamic>? body}) async {
    String? accessToken = await loadData();
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    Uri url ;
    if(body?["statusId"] != null){
      url = Uri.parse(
          '$baseUrl$endPoint?page=${body?["page"]}&size=${body?["size"]}&order=${body?["order"]}&sort=${body?["sort"]}&statusId=${body?["statusId"]}');
    }else{
      url = Uri.parse(
          '$baseUrl$endPoint?page=${body?["page"]}&size=${body?["size"]}&order=${body?["order"]}&sort=${body?["sort"]}');
    }
    if (kDebugMode) {
      print(url);
    }
    var response = await http.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return response;
  }

  Future<http.Response> newApiCall(String endPoint,
      {Map<String, dynamic>? body}) async {
    if (kDebugMode) {
      print("-----------------9999");
    }
    if (kDebugMode) {
      print("$newBaseUrl$endPoint");
    }
    String? accessToken = await loadData();
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    var url = Uri.parse('$newBaseUrl$endPoint');
    var response = await http.get(
      url,
      headers: headers, // Add endPoint here
    );
    return response;
  }

  Future<http.Response> apiCallTypeList(String endPoint,
      {List<String>? body}) async {
    String? accessToken =  await loadData();
    var url = Uri.parse('$newBaseUrl$endPoint');
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    var response = await http.post(
      url,
      headers: headers, // Add endPoint here
      body: body != null ? jsonEncode(body) : null,
    );

    return response;
  }

  Future<http.Response> newApiCallTypePost(String endPoint,
      {Map<String, dynamic>? body}) async {
    String? accessToken = await loadData();

    if (kDebugMode) {

    }
    if (kDebugMode) {
      print(accessToken);
    }
    if (kDebugMode) {
      print('$newBaseUrl$endPoint');
    }
    if (kDebugMode) {
      print(body);
    }
    if (kDebugMode) {

    }
    var url = Uri.parse('$newBaseUrl$endPoint');

    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      url,
      headers: headers, // Add endPoint here
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode != 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      ToastAlert(responseData["message"]);
    }
    return response;
  }

  Future<http.Response> newApiCallTypeListPost(String endPoint,
      {List<Map<String, dynamic>>? body}) async {
    String? accessToken = await loadData();

    if (kDebugMode) {
      print("==============================");
    }
    if (kDebugMode) {
      print(accessToken);
    }
    if (kDebugMode) {
      print('$newBaseUrl$endPoint');
    }
    if (kDebugMode) {
      print(body);
    }
    if (kDebugMode) {
      print("-----------------------------");
    }
    var url = Uri.parse('$newBaseUrl$endPoint');

    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      url,
      headers: headers, // Add endPoint here
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode != 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      ToastAlert(responseData["message"]);
    }
    return response;
  }


  Future<http.Response> sendOtpApi(String endPoint,
      {Map<String, dynamic>? body}) async {
    if (kDebugMode) {
      print("==============================");
    }

    if (kDebugMode) {
      print('$newBaseUrl$endPoint');
    }
    if (kDebugMode) {
      print(body);
    }
    if (kDebugMode) {
      print("-----------------------------");
    }
    var url = Uri.parse('$newBaseUrl$endPoint');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.post(
      url,
      headers: headers, // Add endPoint here
      body: body != null ? jsonEncode(body) : null,
    );
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode != 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      ToastAlert(responseData["message"]);
      ToastAlert(responseData["error"]);
    }
    return response;
  }

  Future<http.Response> deleteApiCallById(
      String endPoint,
      ) async {
    String? accessToken = await loadData();
    var url = Uri.parse('$newBaseUrl$endPoint');

    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    var response = await http.delete(
      url,
      headers: headers, // Add endPoint here
    );
    return response;
  }

  Future<http.Response> newApiCallTypeDelete(String endPoint,
      {Map<String, dynamic>? body}) async {
    String? accessToken = await loadData();
    var url = Uri.parse('$newBaseUrl$endPoint');

    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    var response = await http.delete(
      url,
      headers: headers,
    );

    return response;
  }
}

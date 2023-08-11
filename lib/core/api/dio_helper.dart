import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.43.140:8000/api/',
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
      options: Options(
        // headers: {"authorization": "Bearer $token"},
        headers: {'auth-token': token},
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio!.post(
      url,
      queryParameters: query,
      options: Options(
        headers: {'auth-token': token},
        // headers: {"authorization": "Bearer $token"},
      ),
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    return await dio!.put(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token"},
      ),
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio!.delete(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token"},
      ),
      data: data,
    );
  }

  static Future<dynamic> postWithImage({
    required String endPoint,
    required Map<String, String> body,
    @required List<String>? imagesPath,
    @required String? token,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.43.37:8000/api/$endPoint'),
    );
    request.fields.addAll(body);
    if (imagesPath != null) {
      for (String path in imagesPath) {
        request.files.add(await http.MultipartFile.fromPath('images[]', path));
      }
    }
    request.headers.addAll(
      {
        'Accept': 'application/json',
        if (token != null) 'auth-token': token,
        // if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    http.StreamedResponse response = await request.send();

    http.Response r = await http.Response.fromStream(response);

    if (r.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(r.body);
      log('HTTP POSTIMAGE Data: $data');
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${r.statusCode} and with body : ${r.body}',
      );
    }
  }
}

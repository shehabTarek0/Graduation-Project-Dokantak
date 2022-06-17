import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static var dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://care.ssd-co.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> uploadImage(
      {required String url,
      Map<String, dynamic>? data,
      required File
          file} /*  String name, String email, String pass, String mobile */) async {
    // String filename = file.path.split('/').last;
    FormData formData = FormData.fromMap(data!);
    /* 'name': name,
      'email': email,
      'password': pass,
      'password_confirmation': pass,
      'mobile': mobile,
      'photo': await MultipartFile.fromFile(file.path, filename: filename),
      'address': "cairofdfggff" */

    return dio.post(url, data: formData);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String lang = 'en',
      String c = 'application/json',
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': c,
      'Authorization': token
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

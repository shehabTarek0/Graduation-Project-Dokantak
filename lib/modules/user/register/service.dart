import 'package:g_project/shared/network/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = REGISTER;
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));
    var response = await request.send();
    if (response.statusCode == 200) {
      print(" okkkkkkk ${response.request!.url}");
      return true;
    } else {
      print(" noooooo ${response.request!.url}");

      return false;
    }
  }
}

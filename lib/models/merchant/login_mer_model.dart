class LoginMerModel {
  bool? success;
  Data? data;
  String? message;

  LoginMerModel({this.success, this.data, this.message});

  LoginMerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  String? token;
  String? name;

  Data({this.token, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
  }
}

class LoginUserModel {
  bool? success;
  Data? data;
  String? message;

  LoginUserModel({this.success, this.data, this.message});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  String? token;
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? address;
  String? photo;
  String? age;

  Data(
      {this.token,
      this.id,
      this.name,
      this.email,
      this.mobile,
      this.gender,
      this.address,
      this.photo,
      this.age});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    address = json['address'];
    photo = json['photo'];
    age = json['age'];
  }
}

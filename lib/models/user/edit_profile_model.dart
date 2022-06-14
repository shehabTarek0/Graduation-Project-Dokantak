// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class EditProfile {
  bool? success;
  Data? data;
  String? message;

  EditProfile({this.success, this.data, this.message});

  EditProfile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? photo;
  String? longitude;
  String? latitude;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.photo,
      this.longitude,
      this.latitude,
      this.rememberToken,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    photo = json['photo'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    rememberToken = json['rememberToken'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

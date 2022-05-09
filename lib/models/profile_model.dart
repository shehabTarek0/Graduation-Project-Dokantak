class ProfileModel {
  bool? success;
  Data? data;
  String? message;

  ProfileModel({this.success, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  String? token;
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? photo;
  String? longitude;
  String? latitude;

  Data(
      {this.token,
      this.id,
      this.name,
      this.mobile,
      this.address,
      this.photo,
      this.longitude,
      this.latitude});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    photo = json['photo'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
}

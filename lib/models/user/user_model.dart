class UserProModel {
  bool? success;
  List<Data>? data;
  String? message;

  UserProModel({this.success, this.data, this.message});

  UserProModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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
  // ignore: prefer_void_to_null
  Null rememberToken;
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

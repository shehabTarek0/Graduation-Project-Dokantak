// ignore_for_file: file_names

class FavouritesModel {
  bool? success;
  List<Data>? data;
  String? message;

  FavouritesModel({this.success, this.data, this.message});

  FavouritesModel.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? description;
  int? categoryId;
  String? price;
  String? photo;

  Data(
      {this.id,
      this.productName,
      this.description,
      this.categoryId,
      this.price,
      this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['Product_name'];
    description = json['description'];
    categoryId = json['category_id'];
    price = json['price'];
    photo = json['photo'];
  }
}

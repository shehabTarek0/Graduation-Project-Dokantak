class AllProductsModel {
  bool? success;
  List<Data>? data;
  String? message;

  AllProductsModel({this.success, this.data, this.message});

  AllProductsModel.fromJson(Map<String, dynamic> json) {
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
  String? photo;
  String? price;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.productName,
      this.description,
      this.categoryId,
      this.photo,
      this.price,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['Product_name'];
    description = json['description'];
    categoryId = json['category_id'];
    photo = json['photo'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

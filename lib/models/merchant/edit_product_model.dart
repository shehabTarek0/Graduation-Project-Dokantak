class EditProductModel {
  bool? success;
  Data? data;
  String? message;

  EditProductModel({this.success, this.data, this.message});

  EditProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  int? id;
  String? productName;
  String? description;
  String? categoryId;
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

// ignore_for_file: prefer_void_to_null, unnecessary_question_mark

class CheckOutModel {
  bool? success;
  Data? data;
  String? message;

  CheckOutModel({this.success, this.data, this.message});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  int? id;
  int? clientId;
  String? clientName;
  String? clientPhone;
  String? newAddress;
  String? total;
  String? paymentMethod;
  String? status;
  String? check;
  String? paymentDate;
  Null? userId;
  Null? productId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.clientId,
      this.clientName,
      this.clientPhone,
      this.newAddress,
      this.total,
      this.paymentMethod,
      this.status,
      this.check,
      this.paymentDate,
      this.userId,
      this.productId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientPhone = json['client_phone'];
    newAddress = json['new_address'];
    total = json['total'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    check = json['check'];
    paymentDate = json['Payment_Date'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

import 'dart:convert';

class Dataa {
  int? id;
  String? productName;
  String? description;
  int? categoryId;
  String? price;
  String? photo;

  Dataa(
      {this.id,
      this.productName,
      this.description,
      this.categoryId,
      this.price,
      this.photo});

  factory Dataa.fromJson(Map<String, dynamic> json) => Dataa(
      id: json['id'],
      productName: json['Product_name'],
      description: json['description'],
      categoryId: json['category_id'],
      price: json['price'],
      photo: json['photo']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Product_name'] = productName;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['photo'] = photo;
    return data;
  }

  static String encode(List<Dataa> pro) => json.encode(
        pro.map<Map<String, dynamic>>((pro) => Dataa.toMap(pro)).toList(),
      );

  static List<Dataa> decode(String pro) => (json.decode(pro) as List<dynamic>)
      .map<Dataa>((pro) => Dataa.fromJson(pro))
      .toList();

  static Map<String, dynamic> toMap(Dataa pro) => {
        'id': pro.id,
        'Product_name': pro.productName,
        'description': pro.description,
        'category_id': pro.categoryId,
        'price': pro.price,
        'photo': pro.photo,
      };
}

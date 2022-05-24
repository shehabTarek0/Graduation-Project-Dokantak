import 'dart:convert';
import 'package:g_project/models/data.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future<List<Dataa>> getProducts(String query) async {
    final url =
        Uri.parse('https://care.ssd-co.com/api/client/category/product/12');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> products = map["data"];
      return products.map((json) => Dataa.fromJson(json)).where((data) {
        final productName = data.productName!.toLowerCase();
        final searchLower = query.toLowerCase();
        return productName.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

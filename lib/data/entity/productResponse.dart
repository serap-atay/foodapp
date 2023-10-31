import 'package:foodappwithdio/data/entity/product.dart';

class ProductResponse {

  final List<Product> productlist ;
  final int success;

  ProductResponse({required this.productlist, required this.success});

  factory ProductResponse.fromJson(Map<String ,dynamic> json){
     return ProductResponse(productlist: (json["yemekler"] as List).map((e) => Product.fromJson(e)).toList(), success: json["success"] as int);
  }
}
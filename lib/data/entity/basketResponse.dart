import 'basket.dart';

class BasketResponse {
  final List<Basket> basketList;
  final int success;

  BasketResponse({required this.basketList, required this.success});
  
  factory BasketResponse.fromJson(Map<String, dynamic> json){
    return BasketResponse(basketList: ((json["sepet_yemekler"]) as List).map((e) => Basket.fromJson(e)).toList(), success: json["success"]);
  }
  
}
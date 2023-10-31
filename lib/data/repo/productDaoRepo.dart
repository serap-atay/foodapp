import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foodappwithdio/data/entity/basket.dart';
import 'package:foodappwithdio/data/entity/basketResponse.dart';
import 'package:foodappwithdio/data/entity/product.dart';
import 'package:foodappwithdio/data/entity/productResponse.dart';

class ProductDaoRepository {

  var baseUrl ="http://kasimadalan.pe.hu/yemekler";

  Future<List<Product>> parseProduct (String resp) async{
    var response =json.decode(resp);
    return ProductResponse.fromJson(response).productlist;
  }

  Future<List<Basket>> parseBasketProduct (String resp) async{
    var response =json.decode(resp);
    return BasketResponse.fromJson(response).basketList;
  }

  Future<List<Product>> getProduct() async{
    var url = "$baseUrl/tumYemekleriGetir.php";
    var resp = await Dio().get(url);
    return parseProduct(resp.data.toString());
  }

  Future<void> addProductByBasket(String yemekAdi,String resim,String fiyat,String quantity,String kullaniciAdi ) async{
    var url = "$baseUrl/sepeteYemekEkle.php";
    Map<String,dynamic>  data = {"yemek_adi":yemekAdi,"yemek_resim_adi":resim,"yemek_fiyat":int.parse(fiyat),"yemek_siparis_adet":int.parse(quantity),"kullanici_adi":kullaniciAdi};
    var resp = await Dio().post(url,data:FormData.fromMap(data));
  }

  Future<List<Basket>> getProductByBasket(String kullaniciAdi) async{
    var url = "$baseUrl/sepettekiYemekleriGetir.php";
    Map<String,dynamic> data = {"kullanici_adi" :kullaniciAdi};
      var resp = await Dio().post(url,data:FormData.fromMap(data));
    return parseBasketProduct(resp.data.toString());
  }

  Future<void> deleteProductByBasket(String sepetYemekId,String kullaniciAdi ) async{
    var url = "$baseUrl/sepettenYemekSil.php";
    var data = {"sepet_yemek_id": sepetYemekId, "kullanici_adi":kullaniciAdi};
    var resp = await Dio().post(url,data:FormData.fromMap(data));
    print(resp.data);
  }
}
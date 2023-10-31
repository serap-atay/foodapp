import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodappwithdio/data/entity/product.dart';
import 'package:foodappwithdio/data/entity/productResponse.dart';
import 'package:foodappwithdio/data/repo/productDaoRepo.dart';

class ProductListCubit extends Cubit<List<Product>>{
  ProductListCubit() : super(<Product>[]);

  var pRepo = ProductDaoRepository();
 Future<void> getProducts () async {
   var list = await pRepo.getProduct();
   emit(list);
 }

  Future<void> searchProduct (String yemekAdi) async {
    var products = await pRepo.getProduct();
    var list = <Product>[];
    for(var item in products){
      if(item.yemek_adi.toLowerCase().contains(yemekAdi.toLowerCase())){
        list.add(item);
      }
    }
    emit(list);
  }
}

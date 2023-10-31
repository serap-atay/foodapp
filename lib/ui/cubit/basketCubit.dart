import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodappwithdio/data/entity/basket.dart';
import 'package:foodappwithdio/data/repo/productDaoRepo.dart';

class BasketCubit extends Cubit<List<Basket>>{
  BasketCubit() : super(<Basket>[]);

  var pRepo = ProductDaoRepository();

  Future<void> deleteProductByBasket(String sepetYemekId,String kullaniciAdi ) async{
    var resp = await pRepo.deleteProductByBasket(sepetYemekId, kullaniciAdi);
    await getProductByBasket(kullaniciAdi);
  }

  Future<void> getProductByBasket(String kullaniciAdi) async{
    var list = await pRepo.getProductByBasket(kullaniciAdi);
    emit(list);
  }
}
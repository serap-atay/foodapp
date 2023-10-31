import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodappwithdio/data/repo/productDaoRepo.dart';

class DetailCubit extends Cubit<void>{
  DetailCubit() : super(0);

  var pRepo  = ProductDaoRepository();

  Future<void> addProductByBasket(String yemekAdi,String resim,String fiyat,String quantity,String kullaniciAdi ) async{
    var resp = await pRepo.addProductByBasket(yemekAdi, resim, fiyat, quantity, kullaniciAdi);
  }

}
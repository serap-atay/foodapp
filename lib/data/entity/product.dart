class Product {
  final String yemek_id;
  final String yemek_adi;
  final String yemek_resim_adi;
  final String yemek_fiyat;
  late  bool isliked ;

  Product({required this.yemek_id, required this.yemek_adi, required this.yemek_resim_adi, required this.yemek_fiyat,required this.isliked});

  factory Product.fromJson (Map<String,dynamic> json){
    return Product(yemek_id: json["yemek_id"], yemek_adi: json["yemek_adi"], yemek_resim_adi: json["yemek_resim_adi"], yemek_fiyat: json["yemek_fiyat"],isliked : false);
  }
}
class Basket{
  final String sepet_yemek_id ;
  final String yemek_adi ;
  final String yemek_resim_adi ;
  final String yemek_fiyat ;
  final String yemek_siparis_adet ;
  final String kullanici_adi ;

  Basket({required this.sepet_yemek_id, required this.yemek_adi, required this.yemek_resim_adi, required this.yemek_fiyat, required this.yemek_siparis_adet, required this.kullanici_adi});

  factory Basket.fromJson(Map<String, dynamic> json){
    return Basket(
        sepet_yemek_id: json["sepet_yemek_id"],
        yemek_adi: json["yemek_adi"],
        yemek_resim_adi: json["yemek_resim_adi"],
        yemek_fiyat: json["yemek_fiyat"],
        yemek_siparis_adet: json["yemek_siparis_adet"],
        kullanici_adi: json["kullanici_adi"],);
  }

}
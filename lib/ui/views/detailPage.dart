import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:foodappwithdio/data/entity/product.dart';
import 'package:foodappwithdio/ui/cubit/detailCubit.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key,  required this.product});


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 0;
  int total = 0;
  double value = 3.5;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        leading:  IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.clear)),
       titleSpacing: 100,
       title: const Text("Ürün Detayı", style: TextStyle(fontSize: 20),),
       actions:const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.favorite),
              ),
       ],
      ),
      body :Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top :16.0, right: 20.0),
              child: RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    setState(() {
                      value = v;
                    });
                  },
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 25,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                ),
            ),
            Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.product
                    .yemek_resim_adi}"),
            Text("₺ ${widget.product.yemek_fiyat}",
              style:const TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
            Text(widget.product.yemek_adi,
              style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ElevatedButton(onPressed: (){
                    if(quantity != 0) {
                      setState(() {
                      quantity -=1;
                      total = (quantity * int.parse(widget.product.yemek_fiyat));
                      });
                    }
                },
                   style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                       shape:const RoundedRectangleBorder(),
                   ),
                    child: const Icon(Icons.remove ,color: Colors.white,)),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(quantity.toString(),style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                  shape:const RoundedRectangleBorder()),
                    onPressed: (){
                    setState(() {
                      quantity += 1;
                      total = (quantity * int.parse(widget.product.yemek_fiyat));
                    });
                },
                    child:const Icon(Icons.add,color: Colors.white,)),
              ],
            ),
           const Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("25-35 dk",style: TextStyle(fontSize: 16,),),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Ücretsiz teslimat", style: TextStyle(fontSize: 16),),
                  ),
                ),Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("İndirim %15",style: TextStyle(fontSize: 16,),),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 50,),
                Text("₺ ${total.toString()}",
                  style:const TextStyle(fontSize: 30),),
                ElevatedButton(onPressed: (){
                  context.read<DetailCubit>().addProductByBasket(widget.product.yemek_adi, widget.product.yemek_resim_adi, widget.product.yemek_fiyat, quantity.toString(), "Ekin");
                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                      minimumSize:const Size(220.0, 20.0),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25.0),topLeft:  Radius.circular(10.0)))),
                  child:const Padding(
                    padding:  EdgeInsets.all(12.0),
                    child:  Text("Sepete Ekle",style: TextStyle(fontSize: 24,color: Colors.white)),
                  ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

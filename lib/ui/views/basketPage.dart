import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodappwithdio/data/entity/basket.dart';
import 'package:foodappwithdio/ui/cubit/basketCubit.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int productTotal = 0;
  int total = 0;
  @override
  void initState() {
    super.initState();
    context.read<BasketCubit>().getProductByBasket("Ekin");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 50,
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        title:const Text("Sepetim", style: TextStyle(fontSize: 20),),
        titleSpacing: 100,
       leading: IconButton(onPressed: (){
         Navigator.of(context).pop();
       }, icon:const Icon(Icons.clear)),
      ),
      body :SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<BasketCubit,List<Basket>>(
                  builder: (context , list){
                    total =0;
                    productTotal =0;
                    return ListView.builder(
                      itemCount: list.length,
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          var product = list[index];
                          productTotal = (int.parse(product.yemek_siparis_adet) * int.parse(product.yemek_fiyat));
                          total += productTotal;
                          context.read<BasketCubit>().getProductByBasket("Ekin");
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${product
                                      .yemek_resim_adi}"),
                                ),
                                Column(
                                  children: [
                                    Text(product.yemek_adi , style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                       const Text("Fiyat  : " , style: TextStyle(fontSize: 16),),
                                        Text("₺ ${product.yemek_fiyat}" , style:const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Adet : " , style: TextStyle(fontSize: 16),),
                                        Text(product.yemek_siparis_adet , style:const TextStyle(fontSize: 18),),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(onPressed: (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content:Text("${product.yemek_adi} silinsin mi?"),action: SnackBarAction(label: "Evet", onPressed: (){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${product.yemek_adi} silindi")));
                                            context.read<BasketCubit>().deleteProductByBasket(product.sepet_yemek_id, product.kullanici_adi);
                                            total -=(int.parse(product.yemek_siparis_adet) * int.parse(product.yemek_fiyat));
                                          }),)
                                      );
                                    }, icon:const Icon(Icons.delete)),
                                    Text("₺ ${productTotal.toString()}" , style:const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

                                  ],
                                ),
                              ],
                            ),
                          );

                        });

                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const  Padding(
              padding:  EdgeInsets.only(left: 20.0,right: 20.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gönderim Ücreti : " , style: TextStyle(fontSize: 18),),
                  Text("₺ 0" , style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text("Toplam     : " , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  BlocBuilder<BasketCubit,List<Basket>>(
                    builder: (context , list){
                        return Text("₺ ${total.toString()}", style:const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),);
                      },
                     ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(onPressed: (){
              },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow.shade700,
                  minimumSize:const Size(350.0, 20.0),
                  shape: const RoundedRectangleBorder(),),
                child:const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Text("Sepeti Onayla",style: TextStyle(fontSize: 24,color: Colors.black)),
                ),),
            ),
          ],
        ),

      ),
    );
  }
}

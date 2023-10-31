import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodappwithdio/ui/cubit/productListCubit.dart';
import 'package:foodappwithdio/ui/views/detailPage.dart';
import 'package:foodappwithdio/ui/views/locationPage.dart';

import '../../data/entity/product.dart';
import '../cubit/detailCubit.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  TextEditingController searchController = TextEditingController();
  List<Product> favList =[];
  var control = false;
  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText:"Ara",
                        ),
                        onTap: (){
                          setState(() {
                            control = true;
                          });
                        },
                        onEditingComplete: (){
                          context.read<ProductListCubit>().searchProduct(searchController.text);
                        },
                      ),
                    ),
                   control== false ?  IconButton(onPressed:(){
                   },icon:const Icon(Icons.search_outlined)) :IconButton(onPressed:(){
                     setState(() {
                       control = false;
                       searchController.clear();
                     });
                     context.read<ProductListCubit>().getProducts();
                   } , icon:const Icon(Icons.clear)),
                  ],
                ),
              ),
              BlocBuilder<ProductListCubit,List<Product>>(
              builder: (context, list){
                 if(list.isNotEmpty) {
                  return  GridView.builder(
                    shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1 / 1.6),
                      itemBuilder: (context, index) {
                        var product = list[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> DetailPage(product :product)));
                          },
                          child: Card(
                            elevation: 4,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Align(
                            alignment : Alignment.centerRight,
                                  child:product.isliked ?
                                  IconButton(onPressed: () {
                                    setState(() {
                                      product.isliked = product.isliked ? false : true;
                                    });
                                    control = true;
                                    if(list[index].isliked ==true){
                                      favList.add(list[index]);
                                    }

                                  },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )) :
                                    IconButton(onPressed: () {

                                      setState(() {
                                        product.isliked = product.isliked ? false : true;
                                      });
                                      if(list[index].isliked ==true){
                                        favList.add(list[index]);
                                      }
                                    },
                                        icon: const Icon(
                                          Icons.favorite_outline_rounded,
                                        ))
                                ),
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${product
                                          .yemek_resim_adi}"),
                                ),
                                Text(product.yemek_adi, style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Icon(Icons.directions_bike),
                                    Text("Ücretsiz gönderim")
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Text("₺ ${product.yemek_fiyat.toString()}",
                                      style: const TextStyle(fontSize: 24),),
                                    IconButton(onPressed: () {
                                      context.read<DetailCubit>().addProductByBasket(product.yemek_adi, product.yemek_resim_adi, product.yemek_fiyat, "1", "Ekin");
                                    },
                                        hoverColor: Colors.red,
                                        icon: const Icon(
                                            Icons.add_circle_outline_rounded))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },

                    );
                }else{
                  return const Center();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

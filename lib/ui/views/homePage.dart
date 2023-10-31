import 'package:flutter/material.dart';
import 'package:foodappwithdio/ui/views/basketPage.dart';
import 'package:foodappwithdio/ui/views/productListPage.dart';
import 'locationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedindex = 0;
  var title = "";
  var location ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      appBar:
      AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.indigo,
        title:const Text("Merhaba", style: TextStyle(fontSize: 20,color: Colors.white),),
        titleSpacing: 20,
        shape: const RoundedRectangleBorder(
          borderRadius:BorderRadiusDirectional.only(bottomStart:  Radius.circular(20.0),bottomEnd:  Radius.circular(20.0))
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: OutlinedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationPage()))
              .then((value){
                setState(() {
                  location = value;
                });
              });
            },
                style: OutlinedButton.styleFrom(
                    side:const BorderSide(color: Colors.white)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(Icons.add_location_outlined,color: Colors.white,),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children:
                       [
                         if(location != null) ...[
                        const Padding(
                          padding: EdgeInsets.only(top:6.0),
                          child: Text("Teslimat Adresi",style: TextStyle(color: Colors.white,),),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(bottom:6.0),
                          child: Text(location
                            ,style:const TextStyle(color: Colors.white,),),
                        ),
    ]else ...[
                       const  Text("Lokasyon Giriniz"
                           ,style: TextStyle(color: Colors.white,),),
                         ]
                      ],),
                  ],
                )),
          ),
        ],
      ),
      body :const ProductListPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.indigo,
            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const BasketPage()));
            },
            child: const Icon(Icons.add_shopping_cart ,color: Colors.white,size: 36.0,),
          ),
        ),
      ),
    );
  }
}

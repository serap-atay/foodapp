import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var enlem ;
  var boylam;
  String  location = "";
  Completer<GoogleMapController> haritaKontrol = Completer();

  //39.9032599,32.5979548,11z
  var baslangicKonum = const CameraPosition(target: LatLng(39.9032599,32.5979548),zoom: 11);

  List<Marker> isaretler = <Marker>[];

  Future<void> konumaGit() async {
    GoogleMapController controller = await haritaKontrol.future;
    //41.0370013,28.974792,15z
    var gidilecekKonum =  CameraPosition(target: LatLng(enlem,boylam),zoom: 15);

    var gidilecekIsaret =  Marker(
        markerId:const  MarkerId("id"),
        position: LatLng(enlem,boylam),
        infoWindow:const InfoWindow(title: "Ev",snippet: "Lokasyonum")
    );
    location = "${gidilecekIsaret.infoWindow.title}/${gidilecekIsaret.infoWindow.snippet}";

    setState(() {
      isaretler.add(gidilecekIsaret);
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }
  Future<void> konumBilgisiAl() async {
    var konum = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      enlem = konum.latitude;
      boylam = konum.longitude;
      konumaGit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        title:const Text("Teslimat Adresi Seç", style: TextStyle(fontSize: 20),),
    shape: const RoundedRectangleBorder(
    borderRadius:BorderRadiusDirectional.only(bottomStart:  Radius.circular(20.0),bottomEnd:  Radius.circular(20.0))),
        leadingWidth: 80,
      ),
      body:Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                konumBilgisiAl();
              },
              child:
              const ListTile(
                 leading : Icon(Icons.my_location_outlined ,color: Colors.indigo,),
                 title : Padding(
                   padding: EdgeInsets.all(16.0),
                   child: Text("Bulunduğum Konumu Göster",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                 ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height/1.5,
              child: GoogleMap(
                initialCameraPosition: baslangicKonum,
                mapType: MapType.normal,
                markers: Set<Marker>.of(isaretler),
                onMapCreated: (GoogleMapController controller){
                  haritaKontrol.complete(controller);
                },
              ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop(location);
            },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(MediaQuery.of(context).size.width/1.2, 50.0),backgroundColor: Colors.indigo.shade700),
                child:const Text("Bu konumu kullan", style: TextStyle(fontSize: 20,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}

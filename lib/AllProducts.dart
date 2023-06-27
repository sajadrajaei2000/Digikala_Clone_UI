// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:project2/BottonNav.dart';
import 'package:project2/GoogleMaps.dart';
import 'package:project2/SingleProduct.dart';

import 'model/SpecialModelOffer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<List<SpecialModelOffer>> specialOfferFuture;
  @override
  void initState() {
    super.initState();
    specialOfferFuture = SpecialOfferRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottonNav(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          onPressed: () {},
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            'فروشگاه',
            style: TextStyle(fontFamily: 'Vazir'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoogleMaps()));
                },
                icon: Icon(Icons.map))
          ],
        ),
        body: Container(
          child: FutureBuilder<List<SpecialModelOffer>>(
              future: specialOfferFuture,
              builder: (context, snapshot) {
                List<SpecialModelOffer>? model = snapshot.data;
                if (snapshot.hasData) {
                  return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: List.generate(
                        model!.length,
                        (index) => gridViewItems(model[index]),
                      ));
                } else {
                  return Center(
                    child: JumpingDotsProgressIndicator(
                      color: Colors.black,
                      fontSize: 50,
                      dotSpacing: 20,
                    ),
                  );
                }
              }
              // child: GridView.count(crossAxisCount: 2, shrinkWrap: true, children: [])),
              ),
        ));
  }

  InkWell gridViewItems(SpecialModelOffer specialModelOffer) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleProduct(specialModelOffer)));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                    height: 115,
                    width: 115,
                    child: Image.network(
                      specialModelOffer.imgUrl,
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(specialModelOffer.productName,
                      style: TextStyle(fontFamily: 'Vazir')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        specialModelOffer.off_price,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        specialModelOffer.price,
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<SpecialModelOffer>> SpecialOfferRequest() async {
    List<SpecialModelOffer> model = [];
    var response = await Dio().get(
        'https://api.myjson.online/v1/records/d7595ce8-2ee1-4bef-a060-f5b24b231e63');
    var result = response.data['data'];
    print('special offer json :${result}');
    print(response.statusCode);
    for (var i = 0; i < 14; i++) {
      var data = SpecialModelOffer(
          result[i]['id'],
          result[i]['productName'],
          result[i]['price'],
          result[i]['off_price'],
          result[i]['off_percent'],
          result[i]['imgUrl']);
      model.add(data);
    }
    return model;
  }
}

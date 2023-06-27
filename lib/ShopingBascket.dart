// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:project2/BottonNav.dart';
import 'package:project2/model/ShopingBascketModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopingBascket extends StatefulWidget {
  const ShopingBascket({super.key});

  @override
  State<ShopingBascket> createState() => _ShopingBascketState();
}

class _ShopingBascketState extends State<ShopingBascket> {
  StreamController<ShopingBascketModel> streamController = StreamController();
  @override
  void initState() {
    super.initState();
    getDataFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottonNav(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('سبد خرید', style: TextStyle(fontFamily: 'Vazir')),
      ),
      body: Container(
        child: StreamBuilder<ShopingBascketModel>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ShopingBascketModel? model = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: model!.productOffPrices!.length,
                  itemBuilder: (context, position) {
                    return genrateItems(
                        model.imgUrls![position],
                        model.productNames![position],
                        model.productOffPrices![position]);
                  });
            } else {
              return Center(
                child: JumpingDotsProgressIndicator(
                  color: Colors.black,
                  dotSpacing: 15,
                  fontSize: 40,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Card genrateItems(String imgUrl, String productName, String productPrice) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
        child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10),
                      child: Text(
                        productName,
                        style: TextStyle(fontFamily: 'Vazir', fontSize: 15),
                      ),
                    ),
                    Text(
                      productPrice + ' T',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                )
              ],
            )),
      ),
    );
  }

  Future<void> getDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imgUrls = [];
    List<String> productNames = [];
    List<String> productOffPrices = [];
    imgUrls = prefs.getStringList('imgUrls') ?? [];
    productNames = prefs.getStringList('productNames') ?? [];
    productOffPrices = prefs.getStringList('productPrices') ?? [];
    var model = ShopingBascketModel(imgUrls, productNames, productOffPrices);
    streamController.add(model);
    print('Numbers of favorits products : ${imgUrls.length}');
  }
}

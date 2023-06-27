// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:project2/model/SpecialModelOffer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleProduct extends StatelessWidget {
  SpecialModelOffer specialModelOffer;
  SingleProduct(this.specialModelOffer);
  // List<String>? imgUrls;
  // List<String>? productNames;
  // List<String>? productPrices;
  List<String> imgUrls = [];
  List<String> productNames = [];
  List<String> productOffPrices = [];

  @override
  Widget build(BuildContext context) {
    getDataFromPrefs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'مشخصات',
          style: TextStyle(fontFamily: 'Vazir'),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.network(
                specialModelOffer.imgUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                specialModelOffer.productName,
                style: TextStyle(fontFamily: 'Vazir', fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                specialModelOffer.off_price! + '  T',
                style: TextStyle(
                    fontFamily: 'Vazir', fontSize: 20, color: Colors.red),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Text(
                    ':توضیحات',
                    style: TextStyle(fontSize: 20, fontFamily: 'Vazir'),
                  ),
                )),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      saveDataToSP();
                    },
                    child: Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(fontFamily: 'Vazir', fontSize: 20),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> getDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imgUrls = prefs.getStringList('imgUrls') ?? [];
    productNames = prefs.getStringList('productNames') ?? [];
    productOffPrices = prefs.getStringList('productPrices') ?? [];
    print('Numbers of favorits products : ${imgUrls.length}');
  }

  Future<void> saveDataToSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    imgUrls.add(specialModelOffer.imgUrl);
    productNames.add(specialModelOffer.productName);
    productOffPrices.add(specialModelOffer.off_price);
    preferences.setStringList('imgUrls', imgUrls);
    preferences.setStringList('productNames', productNames);
    preferences.setStringList('productPrices', productOffPrices);
  }
}

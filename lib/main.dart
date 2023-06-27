// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps, non_constant_identifier_names, avoid_unnecessary_containers, unused_local_variable, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:project2/AllProducts.dart';
import 'package:project2/ShopingBascket.dart';
import 'package:project2/SingleProduct.dart';
import 'package:project2/model/EventModel.dart';
import 'package:project2/model/PageViewModel.dart';
import 'package:dio/dio.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:project2/model/SpecialModelOffer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<PageViewModel>> pageViewFuture;
  PageController pageController = PageController();
  late Future<List<SpecialModelOffer>> specialofferfuture;
  late Future<List<EventModel>> eventFuture;

  @override
  void initState() {
    super.initState();
    pageViewFuture = SendRequestPageview();
    specialofferfuture = SpecialOfferRequest();
    eventFuture = SendEventRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Digikala'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShopingBascket()));
              },
              icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 250,
                child: FutureBuilder<List<PageViewModel>>(
                  future: pageViewFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PageViewModel>? model = snapshot.data;
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                              controller: pageController,
                              allowImplicitScrolling: true,
                              itemCount: model!.length,
                              itemBuilder: (context, Position) {
                                return PageViewItems(model[Position]);
                              }),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: model.length,
                              effect: ScrollingDotsEffect(
                                  fixedCenter: true,
                                  activeDotColor: Colors.red,
                                  dotColor: Colors.white),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: JumpingDotsProgressIndicator(
                          color: Colors.black,
                          dotSpacing: 5,
                          fontSize: 60,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  height: 300,
                  color: Colors.red,
                  child: FutureBuilder<List<SpecialModelOffer>>(
                      future: specialofferfuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<SpecialModelOffer>? model = snapshot.data;
                          return ListView.builder(
                              itemCount: model!.length + 1,
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, position) {
                                if (position == 0) {
                                  return Container(
                                      width: 150,
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 5),
                                            child: Image.asset(
                                              "images/pic0.png",
                                              height: 230,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllProducts()));
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        color: Colors.white)),
                                                child: Text('مشاهده همه',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Vazir'))),
                                          )
                                        ],
                                      ));
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SingleProduct(
                                                      model[position - 1])));
                                    },
                                    child:
                                        SpecialOfferItems(model[position - 1]),
                                  );
                                }
                              });
                        } else {
                          return Center(
                              child: JumpingDotsProgressIndicator(
                            color: Colors.black,
                            dotSpacing: 15,
                            fontSize: 40,
                          ));
                        }
                      }),
                ),
              ),
              Container(
                height: 350,
                width: double.infinity,
                child: FutureBuilder<List<EventModel>>(
                  future: eventFuture,
                  builder: (context, snapshot) {
                    List<EventModel>? model = snapshot.data;
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                    width: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.network(model![0].imgUrl!))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                    width: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.network(model[1].imgUrl!))),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                    width: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.network(model[2].imgUrl!))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                    width: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.network(model[3].imgUrl!))),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return JumpingDotsProgressIndicator(
                        fontSize: 25,
                        color: Colors.black,
                        dotSpacing: 15,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container SpecialOfferItems(SpecialModelOffer specialModelOffer) {
    return Container(
      width: 200,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 200,
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.network(specialModelOffer.imgUrl,
                      width: 160, fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  specialModelOffer.productName,
                  style: TextStyle(color: Colors.black, fontFamily: 'Vazir'),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              specialModelOffer.off_price + " T",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              specialModelOffer.price + " T",
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                specialModelOffer.off_precent + '%',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding PageViewItems(PageViewModel pageViewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 5, left: 5),
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              pageViewModel.imgurl,
              fit: BoxFit.fill,
            )),
      ),
    );
  }

  Future<List<PageViewModel>> SendRequestPageview() async {
    List<PageViewModel> model = [];
    var response = await Dio().get(
        'https://api.myjson.online/v1/records/53304bd6-1a84-45fc-962b-e8504646dff3');
    var result = response.data['data'];
    for (var i = 0; i < 5; i++) {
      PageViewModel data = PageViewModel(result[i]['imgUrl']);
      model.add(data);
    }
    print('page view json :${result}');
    return model;
  }

  Future<List<SpecialModelOffer>> SpecialOfferRequest() async {
    List<SpecialModelOffer> model = [];
    var response = await Dio().get(
        'https://api.myjson.online/v1/records/d7595ce8-2ee1-4bef-a060-f5b24b231e63');
    var result = response.data['data'];
    print('special offer json :${result}');
    print(response.statusCode);
    for (var i = 0; i < 7; i++) {
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

  Future<List<EventModel>> SendEventRequest() async {
    List<EventModel> model = [];
    var response = await Dio().get(
        'https://api.myjson.online/v1/records/86b42831-b6f3-4d4c-85cd-f384b59b9209');
    var result = response.data['data'];
    print('Events json :${result}');
    for (var i = 0; i < 4; i++) {
      var data = EventModel(result[i]['imgUrl']);
      model.add(data);
    }
    return model;
  }
}

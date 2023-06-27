// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:project2/ShopingBascket.dart';

class BottonNav extends StatelessWidget {
  const BottonNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.red,
      notchMargin: 8,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        size: 40,
                      ))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => ShopingBascket()));
                      },
                      icon: Icon(
                        Icons.shopping_basket,
                        size: 40,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

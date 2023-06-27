// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        markers: <Marker>{
          Marker(
            infoWindow: InfoWindow(title: 'شعبه دیجی کالا اصفهان'),
            markerId: MarkerId('1'),
            position: LatLng(32.661343, 51.680374),
          ),
          Marker(
            infoWindow: InfoWindow(title: 'شعبه دیجی کالا تهران'),
            markerId: MarkerId('2'),
            position: LatLng(35.715298, 51.404343),
          ),
          Marker(
            infoWindow: InfoWindow(title: 'شعبه دیجی کالا شیراز'),
            markerId: MarkerId('3'),
            position: LatLng(29.591768, 52.583698),
          ),
          Marker(
            infoWindow: InfoWindow(title: 'شعبه دیجی کالا قم'),
            markerId: MarkerId('4'),
            position: LatLng(34.639999, 50.876389),
          ),
          Marker(
            infoWindow: InfoWindow(title: 'شعبه دیجی کالا یزد'),
            markerId: MarkerId('5'),
            position: LatLng(31.897423, 54.356857),
          ),
          Marker(
            infoWindow: InfoWindow(title: 'شعبه دیجی کالا کرمان'),
            markerId: MarkerId('6'),
            position: LatLng(30.283937, 57.083363),
          )
        },
        initialCameraPosition:
            CameraPosition(target: LatLng(35.715298, 51.404343), zoom: 8),
        onMapCreated: (controller) => _controller.complete(controller),
      ),
    );
  }
}

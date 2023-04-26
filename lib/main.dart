import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/home_page.dart';

void main() {
  runApp(const GetMaterialApp(
    title: 'Personagens Marvel',
    home: MarvelScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

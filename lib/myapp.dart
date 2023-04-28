import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel/view/character_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meu App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home:  const MarvelScreen(),
    );
  }
}

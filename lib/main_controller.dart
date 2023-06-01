import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum Status { initial, loading, done, error }

class MainController extends GetxController {
  RxBool english = false.obs;
  Color primary = Color.fromARGB(255, 69, 109, 179);
  Color secondary = Color.fromARGB(255, 255, 71, 98);
  Color accent = Color.fromARGB(255, 229, 227, 241);
  Color black = Color.fromRGBO(0, 0, 0, 1);
  screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  void ar() {
    english(false);
  }

  void en() {
    english(true);
  }
}

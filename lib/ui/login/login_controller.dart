import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zit_sma/ui/orders.dart/orsers_controller.dart';
import '../../main_controller.dart';
import '../categories.dart/categories_controller.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  Map<String, dynamic> data = {};
  final status = Status.initial.obs;
  CategoriesController categoriesController = Get.find();
  OrdersController ordersController = Get.find();

  login() async {
    status(Status.loading);
    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com//storemanagerlogin');
    final response = await http.post(myUrl, body: {
      "username": usernameController.text.trim(),
      "password": passwordController.text
    });
    data = json.decode(response.body);
    data['success'] == true ? status(Status.done) : status(Status.error);

    if (status == Status.done) {
      categoriesController.receiveData(data);
      ordersController.receiveData(data);
      _save(data['data']['token']);
      formKey.currentState?.reset();

      return data['data'];
    } else {
      print(data['message']);
    }
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

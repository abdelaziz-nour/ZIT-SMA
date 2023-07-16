import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zit_sma/ui/dashboard.dart/chane_password_form.dart';
import 'package:http/http.dart' as http;
import '../../main_controller.dart';

class DashboardController extends GetxController {
  var currentTab = 0.obs;
  Rx<Status> status = Status.done.obs;
  RxMap<dynamic, dynamic> data = {}.obs;
  final formKey = GlobalKey<FormState>();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  void changeTab(int index) {
    currentTab.value = index;
  }

  changePassword() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com/changepassword');
    final response = await http.post(myUrl, headers: {
      'Authorization': 'token $value'
    }, body: {
      "Password": oldPassword.text,
      "NewPassword": newPassword.text,
      "ConfirmPassword": confirmPassword.text
    });
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
  }

  void changePasswordForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ChangePasswordForm();
        });
  }
}

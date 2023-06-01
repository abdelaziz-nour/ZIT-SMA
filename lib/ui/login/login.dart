import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/ui/login/login_controller.dart';
import 'package:zit_sma/ui/login/login_form.dart';
import '../../main_controller.dart';

class LoginPage extends StatelessWidget {
  MainController controller = Get.find();
  LoginController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.accent,
      body: ListView(
        children: <Widget>[
          Container(
            height: controller.screenHeight(context) / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/zit.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: controller.english.value
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: controller.english.value
                    ? const EdgeInsets.only(left: 20)
                    : const EdgeInsets.only(right: 20),
                child: Text(
                  controller.english.value ? 'Login' : 'تسجيل دخول',
                  style: TextStyle(fontSize: 40, color: controller.primary),
                ),
              ),
              LoginForm()
            ],
          ),
        ],
      ),
    );
  }
}


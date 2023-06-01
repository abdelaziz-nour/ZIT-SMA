import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_controller.dart';
import '../../widgets/animation.dart';
import 'login_controller.dart';

class LoginForm extends StatelessWidget {
  MainController controller = Get.find();
  LoginController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _controller.formKey,
            child: Column(
              children: <Widget>[
                FadeAnimation(
                    1.8,
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration:const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextFormField(
                              controller: _controller.usernameController,
                              decoration: InputDecoration(
                                  hintTextDirection: controller.english.value
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  border: InputBorder.none,
                                  hintText: controller.english.value
                                      ? "Username"
                                      : 'اسم المستخدم',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return controller.english.value
                                      ? 'username field is required'
                                      : "حقل اسم المستخدم مطلوب";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: _controller.passwordController,
                              decoration: InputDecoration(
                                  hintTextDirection: controller.english.value
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  border: InputBorder.none,
                                  hintText: controller.english.value
                                      ? "Password"
                                      : "كلمة السر",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return controller.english.value
                                      ? 'password field is required'
                                      : "حقل كلمة السر مطلوب";
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Obx(() {
                  if (_controller.status == Status.error) {
                    return Text(
                      controller.english.value
                          ? "No Account Match Giving Credentials. "
                          : "لا يوجد حساب يتضمن البانات المقدمة",
                      style:
                          TextStyle(color: controller.secondary, fontSize: 20),
                    );
                  } else {
                    return Container();
                  }
                }),
                Obx(() {
                  if (_controller.status == Status.loading) {
                    return const CircularProgressIndicator();
                  } else {
                    return FadeAnimation(
                        2,
                        GestureDetector(
                          onTap: () async {
                            if (_controller.formKey.currentState!.validate()) {
                              await _controller.login();
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient:const LinearGradient(colors: [
                                  Color.fromARGB(255, 3, 89, 170),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              child: Text(
                                controller.english.value
                                    ? "Login"
                                    : "تسجيل الدخول",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ));
                  }
                })
              ],
            ),
          )),
    );
  }
}

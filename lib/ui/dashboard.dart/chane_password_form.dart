import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_controller.dart';
import '../categories.dart/categories_controller.dart';
import 'dashboard_controller.dart';

class ChangePasswordForm extends StatelessWidget {
  final MainController controller = Get.find();
  final CategoriesController _controller = Get.find<CategoriesController>();
  final DashboardController dashboardController = Get.find();
  final primaryColor = Color(0xff4338CA);
  final secondaryColor = Color(0xff6D28D9);
  final accentColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AlertDialog(
            backgroundColor: accentColor.withOpacity(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            actions: [
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColor, secondaryColor]),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(12, 26),
                            blurRadius: 50,
                            spreadRadius: 0,
                            color: Colors.grey.withOpacity(.1)),
                      ]),
                  child: Column(children: [
                    CircleAvatar(
                        backgroundColor: accentColor.withOpacity(.05),
                        radius: 25,
                        child: Image.asset('assets/FlutterBricksLogo.png')),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                        controller.english.value
                            ? "Change Paswword"
                            : "تغيير كلمة المرور",
                        style: TextStyle(
                            color: accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Form(
                        key: _controller.formKey,
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: dashboardController.oldPassword,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 20),
                                    hintText: controller.english.value
                                        ? "Current Password"
                                        : "كلمة السر الحالية",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return controller.english.value
                                        ? 'Password field is required'
                                        : "حقل كلمة السر مطلوب";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: dashboardController.newPassword,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 20),
                                    hintText: controller.english.value
                                        ? "New Password"
                                        : "كلمة السر الجديدة",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return controller.english.value
                                        ? 'Password field is required'
                                        : "حقل كلمة السر الجديدة مطلوب";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: dashboardController.confirmPassword,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 20),
                                    hintText: controller.english.value
                                        ? "Confirm Password"
                                        : "تأكيد كلمة السر ",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return controller.english.value
                                        ? 'Password field is required'
                                        : "حقل تأكيد كلمة السر مطلوب";
                                  } else if (dashboardController
                                          .newPassword.text !=
                                      dashboardController
                                          .confirmPassword.text) {
                                    return controller.english.value
                                        ? 'Passwords does not match'
                                        : "كلمتا المرور غير متطابقتين";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              dashboardController.status == Status.error
                                  ? Text(
                                      controller.english.value
                                          ? 'Incorrect password'
                                          : "كلمة المرور خاطئة",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    )
                                  : Container(),
                              dashboardController.status == Status.initial ||
                                      dashboardController.status ==
                                          Status.loading
                                  ? CircularProgressIndicator()
                                  : OutlinedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          alignment: Alignment.center,
                                          side: MaterialStateProperty.all(
                                              BorderSide(
                                                  width: 1,
                                                  color: accentColor)),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.only(
                                                  right: 75,
                                                  left: 75,
                                                  top: 12.5,
                                                  bottom: 12.5)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ))),
                                      onPressed: () async {
                                        ////////////////
                                        if (_controller.formKey.currentState!
                                            .validate()) {
                                          await dashboardController
                                              .changePassword();
                                          if (dashboardController.status ==
                                              Status.done) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    content: Center(
                                                        child: Text(
                                                      controller.english.value
                                                          ? 'Password changed Successfully'
                                                          : "تم تغيير كلمة المرور بنجاح",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.green[900],
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ))));
                                          }
                                          if (dashboardController.status ==
                                              Status.done) {
                                            Get.back();
                                          }
                                        }
                                      },
                                      child: Text(
                                        controller.english.value
                                            ? 'Save'
                                            : "حفظ",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ))
                            ])))
                  ]))
            ]));
  }
}

//if (_controller.formKey.currentState!
                                    //     .validate()) {
                                    //   if (_controller.edit.value == false) {
                                    //     if (_controller.imageFile == null) {
                                    //       final imageBytes = await rootBundle
                                    //           .load('assets/zit.jpg');
                                    //       final imageData =
                                    //           imageBytes.buffer.asUint8List();

                                    //       _controller.imageFile =
                                    //           http.MultipartFile.fromBytes(
                                    //         'Image',
                                    //         imageData,
                                    //         filename: 'zit.jpg',
                                    //         contentType:
                                    //             MediaType('image', 'png'),
                                    //       );

                                    //       await _controller.addCategory();
                                    //     } 
                                    //       await _controller.addCategory();
                                        
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         backgroundColor: Colors.white,
                                        //         content: Center(
                                        //             child: Text(
                                        //           controller.english.value
                                        //               ? 'Category Added Successfully'
                                        //               : "تم إضافة الفئة بنجاح",
                                        //           style: TextStyle(
                                        //               fontSize: 18,
                                        //               color: Colors.green[900],
                                        //               fontStyle:
                                        //                   FontStyle.italic),
                                        //         ))));
                                        // Get.back();
                                    //   } else {
                                    //     if (_controller.imageFile == null) {
                                    //       final imageBytes = await rootBundle
                                    //           .load('assets/zit.jpg');
                                    //       final imageData =
                                    //           imageBytes.buffer.asUint8List();

                                    //       _controller.imageFile =
                                    //           http.MultipartFile.fromBytes(
                                    //         'Image',
                                    //         imageData,
                                    //         filename: 'zit.jpg',
                                    //         contentType:
                                    //             MediaType('image', 'png'),
                                    //       );

                                    //       await _controller.editCategory();
                                    //     } else {
                                    //       await _controller.editCategory();
                                    //     }
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(SnackBar(
                                    //             backgroundColor: Colors.white,
                                    //             content: Center(
                                    //                 child: Text(
                                    //               controller.english.value
                                    //                   ? 'Category Updated Successfully'
                                    //                   : "تم تحديث الفئة بنجاح",
                                    //               style: TextStyle(
                                    //                   fontSize: 18,
                                    //                   color: Colors.green[900],
                                    //                   fontStyle:
                                    //                       FontStyle.italic),
                                    //             ))));
                                    //     Get.back();
                                    //   }
                                    // }
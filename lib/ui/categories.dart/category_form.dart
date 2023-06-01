import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';

class CategoryForm extends StatelessWidget {
  final MainController controller = Get.find();
  final CategoriesController _controller = Get.find<CategoriesController>();
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
                            ? "Category Informations"
                            : "بيانات الفئة",
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
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: _controller.categoryNameController,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 20),
                                    hintText: controller.english.value
                                        ? "Category Name"
                                        : "إسم الفئة",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return controller.english.value
                                        ? 'Categpry name field is required'
                                        : "حقل اسم الفئة مطلوب";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              OutlinedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    alignment: Alignment.center,
                                    side: MaterialStateProperty.all(BorderSide(
                                        width: 1, color: accentColor)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(
                                            right: 35,
                                            left: 35,
                                            top: 12.5,
                                            bottom: 12.5)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ))),
                                onPressed: () async {
                                  _controller.imageFile = await _controller
                                      .myFunctions
                                      .getFromGallery();
                                },
                                child: Text(
                                  controller.english.value
                                      ? 'Add Image'
                                      : "اضافة صورة",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              OutlinedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      alignment: Alignment.center,
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              width: 1, color: accentColor)),
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
                                    if (_controller.formKey.currentState!
                                        .validate()) {
                                      if (_controller.edit.value == false) {
                                        if (_controller.imageFile == null) {
                                          final imageBytes = await rootBundle
                                              .load('assets/zit.jpg');
                                          final imageData =
                                              imageBytes.buffer.asUint8List();

                                          _controller.imageFile =
                                              http.MultipartFile.fromBytes(
                                            'Image',
                                            imageData,
                                            filename: 'zit.jpg',
                                            contentType:
                                                MediaType('image', 'png'),
                                          );

                                          await _controller.addCategory();
                                        } else {
                                          await _controller.addCategory();
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.white,
                                                content: Center(
                                                    child: Text(
                                                  controller.english.value
                                                      ? 'Category Added Successfully'
                                                      : "تم إضافة الفئة بنجاح",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green[900],
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ))));
                                        Get.back();
                                      } else {
                                        if (_controller.imageFile == null) {
                                          final imageBytes = await rootBundle
                                              .load('assets/zit.jpg');
                                          final imageData =
                                              imageBytes.buffer.asUint8List();

                                          _controller.imageFile =
                                              http.MultipartFile.fromBytes(
                                            'Image',
                                            imageData,
                                            filename: 'zit.jpg',
                                            contentType:
                                                MediaType('image', 'png'),
                                          );

                                          await _controller.editCategory();
                                        } else {
                                          await _controller.editCategory();
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.white,
                                                content: Center(
                                                    child: Text(
                                                  controller.english.value
                                                      ? 'Category Updated Successfully'
                                                      : "تم تحديث الفئة بنجاح",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green[900],
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ))));
                                        Get.back();
                                      }
                                    }
                                  },
                                  child: Text(
                                    controller.english.value
                                        ? 'Finish'
                                        : "إنهاء",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
                            ])))
                  ]))
            ]));
  }
}

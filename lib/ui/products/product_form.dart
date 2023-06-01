import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';

class ProductForm extends StatelessWidget {
  MainController controller = Get.find();
  ProductsController _controller = Get.find();
  final primaryColor = Color(0xff4338CA);
  final secondaryColor = Color(0xff6D28D9);
  final accentColor = Color(0xffffffff);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: accentColor.withOpacity(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: [
            Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [primaryColor, secondaryColor]),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(12, 26),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.1)),
                  ]),
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundColor: accentColor.withOpacity(.05),
                      radius: 25,
                      child: Image.asset('assets/FlutterBricksLogo.png')),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      controller.english.value
                          ? "Product Infromations"
                          : "بيانات المنتج",
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
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            controller: _controller.productNameController,
                            decoration: InputDecoration(
                                hintText: controller.english.value
                                    ? "Product Name"
                                    : "اسم المنتج",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return controller.english.value
                                    ? 'Product Name field is required'
                                    : "حقل اسم المنتج مطلوب";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            controller: _controller.productSubtitleController,
                            decoration: InputDecoration(
                                hintText: controller.english.value
                                    ? "Description"
                                    : "الوصف",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return controller.english.value
                                    ? ' Description field is required'
                                    : "حقل الوصف مطلوب";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            controller: _controller.productPriceController,
                            decoration: InputDecoration(
                                hintText: controller.english.value
                                    ? "Price"
                                    : "السعر",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return controller.english.value
                                    ? ' Price field is required'
                                    : "حقل السعر مطلوب";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,
                            controller: _controller.productQuantityController,
                            decoration: InputDecoration(
                                hintText: controller.english.value
                                    ? "Quantity"
                                    : "الكمية",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return controller.english.value
                                    ? ' Quantity field is required'
                                    : "حقل الكمية مطلوب";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                alignment: Alignment.center,
                                side: MaterialStateProperty.all(
                                    BorderSide(width: 1, color: accentColor)),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            if (_controller.status == Status.initial ||
                                _controller.status == Status.loading) {
                              return const CircularProgressIndicator();
                            } else {
                              return OutlinedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    alignment: Alignment.center,
                                    side: MaterialStateProperty.all(BorderSide(
                                        width: 1, color: accentColor)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(
                                            right: 75,
                                            left: 75,
                                            top: 12.5,
                                            bottom: 12.5)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ))),
                                onPressed: () async {
                                  try {
                                    if (_controller.formKey.currentState!
                                        .validate()) {
                                      if (_controller.edit == false) {
                                        await _controller.addProduct();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.white,
                                                content: Center(
                                                    child: Text(
                                                  controller.english.value
                                                      ? 'Product Added Successfully'
                                                      : "تم إضافة المنتج بنجاح",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green[900],
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ))));
                                        Get.back();
                                      } else {
                                        await _controller.editProduct();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.white,
                                                content: Center(
                                                    child: Text(
                                                  controller.english.value
                                                      ? 'Product Edited Successfully'
                                                      : "تم تعديل المنتج بنجاح",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.green[900],
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ))));
                                        Get.back();
                                      }
                                    }
                                  } catch (e) {
                                    _controller.status(Status.done);
                                    return _controller.myFunctions.noImageField(
                                        context, controller.english.value);
                                  }
                                },
                                child: Text(
                                  controller.english.value ? 'Finish' : "إنهاء",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

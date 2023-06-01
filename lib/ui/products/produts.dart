import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';

import '../../widgets/search_bar.dart';
import 'product_card.dart';

class ProductsPage extends StatelessWidget {
  MainController controller = Get.find();
  ProductsController _controller = Get.find();
  CategoriesController categoryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.accent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: controller.accent,
        elevation: 0,
        leading: BackButton(
          color: controller.black,
          onPressed: () {
            Get.back();
          },
        ),
        title: Obx(
          () => Text(
            _controller.currentCategory['Name'],
            style: TextStyle(color: controller.primary),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              categoryController.showDeleteCategoryDialog(context);
            },
            icon: Icon(
              Icons.delete,
              color: controller.secondary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return SearchInputFb1(
                  hintText:
                      controller.english.value ? 'Search ...' : "البحث...",
                  onchange: (val) {
                    _controller.setSearchQuery(val);
                  },
                );
              }),
              Align(
                alignment: controller.english.value
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    controller.english.value ? "Add Product" : "اضافة منتج",
                    style: TextStyle(
                      color: controller.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    _controller.edit(false);
                    _controller.showProductForm(context);
                  },
                ),
              ),
              Obx(() {
                if (_controller.status == Status.loading ||
                    _controller.status == Status.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return ProductCard();
                  
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

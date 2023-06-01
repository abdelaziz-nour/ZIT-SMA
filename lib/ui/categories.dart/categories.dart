import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';
import 'package:zit_sma/widgets/search_bar.dart';

import 'category_card.dart';

class Categories extends StatelessWidget {
  MainController controller = Get.find();
  CategoriesController _controller = Get.find();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.accent,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputFb1(
                hintText: controller.english.value ? 'Search ..' : '.. بحث',
                onchange: (value) {
                  _controller.filterCategories(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Align(
                  alignment: controller.english.value
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      controller.english.value ? "Add Category" : "إضافة فئة",
                      style: TextStyle(
                        color: controller.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      _controller.edit(false);
                      _controller.showCategoryForm(context);
                    },
                  ),
                ),
              ),
              Obx(() {
                if (_controller.status == Status.initial ||
                    _controller.status == Status.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return CategoryCard();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

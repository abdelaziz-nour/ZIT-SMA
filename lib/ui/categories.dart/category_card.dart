import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';

import '../../main_controller.dart';

class CategoryCard extends StatelessWidget {
  final CategoriesController _controller = Get.find<CategoriesController>();
  final ProductsController controller = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _controller.filteredCategories.length,
        itemBuilder: (context, index) {
          var card = _controller.filteredCategories[index];

          return GestureDetector(
            onTap: () {
              controller.currentCategory(card);
              controller.getMyProducts();
              Get.toNamed('/products');
            },
            onLongPress: () {
              _controller.edit(true);
              _controller.editedCategory(card['id']);
              _controller.showCategoryForm(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xff53E88B), Color(0xff15BE77)],
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'http://vzzoz.pythonanywhere.com${card['Image']}',
                        fit: BoxFit.fill,
                        height: 10000,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Center(
                              child: Text(
                                card['Name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

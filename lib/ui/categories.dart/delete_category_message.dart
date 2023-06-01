import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';

class DeleteCategoryDialog extends StatelessWidget {
  MainController controller = Get.find();
  CategoriesController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(controller.english.value ? 'Delete' : 'حذف'),
        content: Text(controller.english.value
            ? 'Do you want to delete this category ?'
            : 'هل انت متأكد من حذف هذه الفئة'),
        actions: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 11, 35, 55)),
              child: Text(
                controller.english.value ? 'No' : "لا",
              ),
              onPressed: () {
                Get.back();
              }),
          Obx(() {
            if (_controller.status == Status.initial ||
                _controller.status == Status.loading) {
              return const CircularProgressIndicator();
            } else {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    controller.english.value ? 'Yes' : "نعم",
                  ),
                  onPressed: () async {
                    await _controller.deleteCategory();
                    Get.offNamed('dashboard');
                  });
            }
          })
        ]);
  }
}

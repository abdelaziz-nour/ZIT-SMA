import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';

class ProductsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => CategoriesController());
    
  }
}
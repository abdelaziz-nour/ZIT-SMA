import 'package:get/get.dart';
import 'package:zit_sma/bindings/products_binding.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';
import 'package:zit_sma/ui/dashboard.dart/dashboard_controller.dart';
import 'package:zit_sma/ui/login/login_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';

class CategoriesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CategoriesController());
    Get.lazyPut(() => ProductsController());
  }
}

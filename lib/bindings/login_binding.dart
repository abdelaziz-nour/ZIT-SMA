import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/login/login_controller.dart';
import 'package:zit_sma/ui/orders.dart/orsers_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';

import '../ui/categories.dart/categories_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => LoginController());
    Get.put(ProductsController(), permanent: true);
    Get.put(CategoriesController(), permanent: true);
    Get.put(OrdersController(), permanent: true);
  }
}

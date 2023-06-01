import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>MainController());
  }
}
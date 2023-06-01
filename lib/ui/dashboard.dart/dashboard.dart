import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/categories.dart/categories.dart';
import 'package:zit_sma/ui/categories.dart/categories_controller.dart';
import 'package:zit_sma/ui/dashboard.dart/dashboard_controller.dart';
import '../orders.dart/orders.dart';


class Dashboard extends StatelessWidget {
  MainController controller = Get.find();
  DashboardController _controller = Get.find();
  CategoriesController categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Categories(),
      OrdersPage()
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: controller.accent,
        elevation: 0,
        title: Text(categoriesController.received['data']['StoreName'],
            style: TextStyle(color: controller.primary)),
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed('/login');
            },
            icon: Icon(
              Icons.logout_sharp,
              color: controller.primary,
            )),
      ),
      body: Obx(() => widgetOptions.elementAt(_controller.currentTab.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor:const Color.fromARGB(255, 76, 154, 203),
          currentIndex: _controller.currentTab.value,
          onTap: (index) => _controller.changeTab(index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.category_outlined),
              label: controller.english.value ? 'Categories' : "الفئات",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.payments_outlined),
              label: controller.english.value ? 'Follow-ups' : "المتابعة",
            ),
          ],
        ),
      ),
    );
  }
}

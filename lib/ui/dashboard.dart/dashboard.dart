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
    final List<Widget> widgetOptions = <Widget>[Categories(), OrdersPage()];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 69, 109, 179)),
        centerTitle: true,
        backgroundColor: controller.accent,
        elevation: 0,
        title: Text(categoriesController.received['data']['StoreName'],
            style: TextStyle(color: controller.primary)),
        // leading: IconButton(
        // onPressed: () {
        //   Get.offAllNamed('/login');
        // },
        //     icon: Icon(
        //       Icons.logout_sharp,
        //       color: controller.primary,
        //     )),
      ),
      body: Obx(() => widgetOptions.elementAt(_controller.currentTab.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 76, 154, 203),
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
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                    image: NetworkImage('https://vzzoz.pythonanywhere.com' +
                        categoriesController.received['data']['StoreImage']),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container()),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                categoriesController.received['data']['StoreName'],
                style:
                    TextStyle(fontSize: controller.screenWidth(context) / 15),
              ),
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: Text(controller.english.value
                  ? 'Change Password'
                  : 'تغيير كلمة المرور'),
              onTap: () {
                _controller.changePasswordForm(context);
              },
            ),
            ListTile(
              onTap: () {
                Get.offAllNamed('/login');
              },
              leading: Icon(Icons.logout),
              title: Text(controller.english.value ? 'Logout' : 'تسجيل خروج'),
            ),
          ],
        ),
      ),
    );
  }
}

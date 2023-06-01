import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zit_sma/bindings/categories.binding.dart';
import 'package:zit_sma/bindings/dahsboard_binding.dart';
import 'package:zit_sma/bindings/login_binding.dart';
import 'package:zit_sma/ui/categories.dart/categories.dart';
import 'package:zit_sma/ui/categories.dart/category_form.dart';
import 'package:zit_sma/ui/dashboard.dart/dashboard.dart';
import 'package:zit_sma/ui/login/login.dart';
import 'package:zit_sma/ui/ordered_Items.dart/ordered_items.dart';
import 'package:zit_sma/ui/orders.dart/orders.dart';
import 'package:zit_sma/ui/products/produts.dart';
import 'package:zit_sma/ui/start/start_screen.dart';

import 'bindings/main_binding.dart';
import 'bindings/orders_binding.dart';
import 'bindings/products_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/start',
      theme: ThemeData(
            fontFamily: GoogleFonts.amiri(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                .fontFamily),
      initialBinding: MainBindings(),
      getPages: [
        GetPage(name: '/start', page: ()=> StartPage(),binding: MainBindings()),
        GetPage(name: '/login', page: ()=> LoginPage(),binding: LoginBindings()),
        GetPage(name: '/dashboard', page: ()=> Dashboard(),binding: DashboardBindings()),
        GetPage(name: '/categories', page: ()=> Categories(),binding: CategoriesBindings()),
        GetPage(name: '/products', page: ()=> ProductsPage(),binding: ProductsBindings()),
        GetPage(name: '/orders', page: ()=> OrdersPage(),binding: OrdersBindings()),
        GetPage(name: '/ordered_items', page: ()=> OrderedItems(),binding: OrdersBindings()),


      ],
    );
  }
}


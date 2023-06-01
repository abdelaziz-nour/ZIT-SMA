import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_controller.dart';
import '../../widgets/custom_button.dart';
import '../login/login.dart';

class StartPage extends StatelessWidget {
  MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: controller.accent,
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/zit.jpg'), fit: BoxFit.fill)),
              ),
            ),
            Text(
              'Zoal IT',
              style: TextStyle(
                color: controller.primary,
                fontSize: controller.screenHeight(context) / 15,
                fontFamily: 'Pacifico',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: controller.screenHeight(context) / 15,
                    width: controller.screenWidth(context) / 2.5,
                    child: ButtonImage(
                      onPressed: () {
                        controller.ar();
                        Get.toNamed('/login');
                      },
                      text: 'عربي',
                    )),
                SizedBox(
                    height: controller.screenHeight(context) / 15,
                    width: controller.screenWidth(context) / 2.5,
                    child: ButtonImage(
                      onPressed: () {
                        controller.en();
                        Get.toNamed('/login');
                      },
                      text: 'English',
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/orders.dart/orsers_controller.dart';
import 'package:zit_sma/widgets/search_bar.dart';

class OrdersPage extends StatelessWidget {
  MainController controller = Get.find();
  OrdersController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.accent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: controller.english.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'O',
                          style: TextStyle(
                              color: controller.primary, fontSize: 30),
                        ),
                        Text(
                          'rders',
                          style:
                              TextStyle(color: controller.black, fontSize: 30),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'لبات',
                          style:
                              TextStyle(color: controller.black, fontSize: 30),
                        ),
                        Text(
                          'الطـ',
                          style: TextStyle(
                              color: controller.primary, fontSize: 30),
                        ),
                      ],
                    ),
            ),
            SearchInputFb1(
              hintText: controller.english.value ? 'Search ...' : "البحث...",
              onchange: (val) {
                _controller.filterOrders(val);
              },
            ),
            Obx(() {
              if (_controller.status == Status.initial ||
                  _controller.status == Status.loading) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _controller.filteredOrders.length,
                  itemBuilder: (context, index) {
                    var order = _controller.filteredOrders[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        onTap: () {
                          _controller.currentOrderItems(order['OrderItems']);
                          _controller.currentOrder(order);
                          _controller.newOrderStatus(order['Status']);
                          Get.toNamed('/ordered_items', arguments: {
                            'Location': order['Location'],
                          });
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['id'].toString(),
                              style:const TextStyle(fontSize: 18),
                            ),
                            Text(
                              order['Status'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: order['Status'] == 'Canceled'
                                    ? Colors.red
                                    : order['Status'] == 'OnDelivery'
                                        ? Colors.orange
                                        : order['Status'] == 'Preparing'
                                            ? Colors.black
                                            : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          order['CreatedBy'],
                          style: TextStyle(
                              color: controller.primary, fontSize: 18),
                        ),
                        trailing: Text(
                          order['CreatedOn'].substring(0, 16),
                          style:const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

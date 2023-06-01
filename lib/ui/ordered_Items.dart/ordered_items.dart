import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/orders.dart/orsers_controller.dart';

class OrderedItems extends StatelessWidget {
  MainController controller = Get.find();
  OrdersController _controller = Get.find();
  num total = 0;

  @override
  Widget build(BuildContext context) {
    Map map = _controller.currentOrderItems.asMap();
    for (var item in _controller.currentOrderItems) {
      total = total + item['Subtotal'];
    }
    return Scaffold(
      backgroundColor: controller.accent,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: controller.accent,
          elevation: 0,
          leading: BackButton(
            color: controller.black,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            _controller.received['data']['StoreName'],
            style: TextStyle(color: controller.primary),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: controller.english.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(color: controller.black, fontSize: 20),
                      ),
                      Text(
                        '$total SDG',
                        style:
                            TextStyle(color: controller.primary, fontSize: 20),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$total SDG',
                        style:
                            TextStyle(color: controller.primary, fontSize: 20),
                      ),
                      Text(
                        'المبلغ',
                        style: TextStyle(color: controller.black, fontSize: 20),
                      ),
                    ],
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(() {
                    if (_controller.status == Status.initial ||
                        _controller.status == Status.loading) {
                      return const CircularProgressIndicator();
                    } else {
                      return DropdownButton<String>(
                        dropdownColor: controller.primary,
                        underline: const SizedBox(),
                        value: _controller.newOrderStatus.value,
                        borderRadius: BorderRadius.circular(20),
                        onChanged: (String? newValue) {
                          _controller.newOrderStatus(newValue);
                        },
                        items: _controller.newOrderStatus.value == 'Preparing'
                            ? <String>[
                                'Preparing',
                                'OnDelivery',
                                'Delivered',
                                'Canceled'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: value == 'Canceled'
                                            ? Colors.red
                                            : value == 'OnDelivery'
                                                ? Colors.orange
                                                : value == 'Preparing'
                                                    ? Colors.black
                                                    : Colors.green),
                                  ),
                                );
                              }).toList()
                            : <String>['OnDelivery', 'Delivered', 'Canceled']
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: value == 'Canceled'
                                            ? Colors.red
                                            : value == 'OnDelivery'
                                                ? Colors.orange
                                                : value == 'Preparing'
                                                    ? Colors.black
                                                    : Colors.green),
                                  ),
                                );
                              }).toList(),
                      );
                    }
                  })),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    child: Text(controller.english.value ? 'Save' : 'حفظ',
                        style:
                            TextStyle(fontSize: 20, color: controller.primary)),
                    onPressed: () async {
                      await _controller.changeOrderStatus();
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              _controller.currentOrder['Location'],
              style: const TextStyle(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
          ),
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          controller.english.value ? 'No' : "رقم",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: controller.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          controller.english.value ? 'Product' : "المنتج",
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: controller.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          controller.english.value ? 'Quantity' : "الكمية",
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: controller.primary,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          controller.english.value ? 'Price' : "السعر",
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: controller.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          controller.english.value ? 'Subtotal' : "المجموع",
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: controller.primary),
                        ),
                      ),
                    ],
                    rows: map.entries
                        .map(
                          (entry) => DataRow(
                            cells: [
                              DataCell(Text(
                                (entry.key + 1).toString(),
                              )),
                              DataCell(Text(
                                entry.value['ProductName'],
                                style:const TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                              DataCell(Center(
                                  child:
                                      Text((entry.value['Quantity']).toString(),
                                          style:const TextStyle(
                                            fontSize: 18,
                                          )))),
                              DataCell(Text((entry.value['Price']).toString(),
                                  style:const TextStyle(
                                    fontSize: 18,
                                  ))),
                              DataCell(
                                  Text((entry.value['Subtotal']).toString(),
                                      style:const TextStyle(
                                        fontSize: 18,
                                      ))),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main_controller.dart';

class OrdersController extends GetxController {
  Rx<Status> status = Status.initial.obs;
  RxMap<dynamic, dynamic> received = {}.obs;
  RxMap<dynamic, dynamic> data = {}.obs;
  RxMap<dynamic, dynamic> currentOrder = {}.obs;
  RxList currentOrderItems = [].obs;
  RxString newOrderStatus = ''.obs;
  RxList<Map<String, dynamic>> filteredOrders = <Map<String, dynamic>>[].obs;

  void filterOrders(String searchQuery) {
    status(Status.loading);
    if (searchQuery.isEmpty) {
      filteredOrders.assignAll(List<Map<String, dynamic>>.from(data['data']));
    } else {
      filteredOrders.assignAll(List<Map<String, dynamic>>.from(
        data['data'].where((order) {
          String orderId = order['id'].toString().toLowerCase();
          return orderId.contains(searchQuery.toLowerCase());
        }),
      ));
    }
    status(Status.done);
  }

  receiveData(Map<String, dynamic> newData) async {
    status(Status.loading);
    received(newData);
    await getMyOrders();
    status(Status.done);
  }

  getMyOrders() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com/getstoreorders');
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Store": received['data']['StoreID']});
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
    filteredOrders.assignAll(List<Map<String, dynamic>>.from(data['data']));
  }

  changeOrderStatus() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/changeorderstatus");
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Order": currentOrder['id'], "Status": newOrderStatus.value});
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
    print(data);
    await getMyOrders();
  }
}

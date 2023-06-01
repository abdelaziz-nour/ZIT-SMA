import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zit_sma/bindings/categories.binding.dart';
import 'package:zit_sma/ui/products/product_form.dart';
import '../../functions/functions.dart';
import '../../main_controller.dart';
import '../categories.dart/categories_controller.dart';

class ProductsController extends GetxController {
  RxMap<dynamic, dynamic> received = {}.obs;
  RxMap<dynamic, dynamic> data = {}.obs;
  Rx<Status> status = Status.initial.obs;
  RxMap currentCategory = {}.obs;
  RxList<RxBool> expand = <RxBool>[].obs;
  RxMap currentProduct = {}.obs;
  RxInt newQuantity = 0.obs;
  RxString searchQuery = ''.obs;
  RxList<Map<String, dynamic>> filteredProducts = <Map<String, dynamic>>[].obs;

  final formKey = GlobalKey<FormState>();
  RxBool edit = false.obs;
  final productNameController = TextEditingController();
  final productSubtitleController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();
  MyFunctions myFunctions = MyFunctions();
  http.MultipartFile? imageFile;

  receiveData(RxMap<dynamic, dynamic> newData) {
    received(newData);
  }

  getMyProducts() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    Uri myUrl =
        Uri.parse('http://vzzoz.pythonanywhere.com/getcategoryproducts');
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Category": currentCategory['id']});
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
    expand.assignAll(List.generate(data['data'].length, (_) => false)
        .map((value) => value.obs));
    filterProducts();
    print(data);
  }

  updateProductQuantity() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/addproductquantity");
    var response = await http.post(myUrl, headers: {
      'Authorization': 'token $value'
    }, body: {
      "Product": currentProduct['id'],
      "Quantity": newQuantity.value.toString()
    });
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
    await getMyProducts();
  }

  deleteProduct() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/deleteproduct");
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Product": currentProduct['id']});
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
    await getMyProducts();
    print(data);
  }

  addProduct() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://vzzoz.pythonanywhere.com/addproduct"),
    );

    request.headers["Authorization"] = "token $value";
    request.fields["Name"] = productNameController.text;
    request.fields["Description"] = productSubtitleController.text;
    request.fields["Price"] = productPriceController.text.toString();
    request.fields["Quantity"] = productQuantityController.text.toString();
    request.fields["Category"] = currentCategory['id'];
    request.files.add(imageFile!);
    http.StreamedResponse response = await request.send();
    status(Status.done);
    imageFile = null;
    await getMyProducts();
    formKey.currentState?.reset();
  }

  editProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://vzzoz.pythonanywhere.com/updateproduct"),
    );
    request.headers["Authorization"] = "token $value";
    request.fields["Product"] = currentProduct['id'];
    request.fields["Name"] = productNameController.text;
    request.fields["Description"] = productSubtitleController.text;
    request.fields["Price"] = productPriceController.text;
    request.fields["Quantity"] = productQuantityController.text;
    request.files.add(imageFile!);
    var response = await request.send();
    status(Status.done);
    imageFile = null;
    await getMyProducts();
    formKey.currentState?.reset();
  }

  void increaseQuantity() {
    newQuantity++;
  }

  void decreaseQuantity() {
    if (newQuantity > 0) {
      newQuantity--;
    }
  }

  void updateQuantity(int updatedQuantity) async {
    newQuantity(updatedQuantity);
    await updateProductQuantity();
    await getMyProducts();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void filterProducts() {
    filteredProducts.assignAll((data['data'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .where((product) => product['Name']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()))
        .toList());
  }

  void showProductForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ProductForm();
        });
  }

  @override
  void onInit() {
    super.onInit();
    ever(currentProduct, (_) {
      newQuantity(currentProduct['Quantity']);
    });
  }
}

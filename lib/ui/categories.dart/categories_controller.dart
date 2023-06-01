import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zit_sma/ui/categories.dart/delete_category_message.dart';
import 'package:zit_sma/ui/products/products_controller.dart';
import '../../functions/functions.dart';
import '../../main_controller.dart';
import 'category_form.dart';

class CategoriesController extends GetxController {
  RxMap<dynamic, dynamic> received = {}.obs;
  RxMap<dynamic, dynamic> data = {}.obs;
  Rx<Status> status = Status.initial.obs;
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  RxBool edit = false.obs;
  http.MultipartFile? imageFile;
  MyFunctions myFunctions = MyFunctions();
  RxString editedCategory = ''.obs;
  ProductsController controller = Get.find();
  RxList<Map<String, dynamic>> filteredCategories =
      <Map<String, dynamic>>[].obs;

  void filterCategories(String searchQuery) {
    if (searchQuery.isEmpty) {
      filteredCategories
          .assignAll(List<Map<String, dynamic>>.from(data['data']));
    } else {
      filteredCategories.assignAll(List<Map<String, dynamic>>.from(
        data['data'].where((category) {
          String categoryName = category['Name'].toString().toLowerCase();
          return categoryName.contains(searchQuery.toLowerCase());
        }),
      ));
    }
  }

  receiveData(Map<String, dynamic> newData) async {
    status(Status.loading);
    received(newData);
    await getMyCategories();
    status(Status.done);
    Get.offNamed('/dashboard');
  }

  Future<void> getMyCategories() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com/getstorecategories');
    final response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Store": received['data']['StoreID']});
    data(json.decode(response.body));
    data['success'] == true ? status(Status.done) : status(Status.error);
    filteredCategories.assignAll(List<Map<String, dynamic>>.from(data['data']));

    controller.receiveData(data);
  }

  addCategory() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://vzzoz.pythonanywhere.com/addcategory"),
    );

    request.headers["Authorization"] = "token $value";
    request.fields["Name"] = categoryNameController.text;
    request.files.add(imageFile!);

    StreamedResponse response = await request.send();
    imageFile = null;
    await getMyCategories();
    formKey.currentState?.reset();

  }

  editCategory() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;

    // send the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://vzzoz.pythonanywhere.com/updatecategory"),
    );

    request.headers["Authorization"] = "token $value";
    request.fields["Category"] = editedCategory.value;
    request.fields["Name"] = categoryNameController.text;
    request.files.add(imageFile!);
    StreamedResponse response = await request.send();
    data['success'] == true ? status(Status.done) : status(Status.error);
    imageFile = null;
    await getMyCategories();
    formKey.currentState?.reset();
  }

  deleteCategory() async {
    status(Status.loading);
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/deletecategory");
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Category": controller.currentCategory['id']});
    data['success'] == true ? status(Status.done) : status(Status.error);
    data(json.decode(response.body));
    await getMyCategories();
    print(data);
  }

  void showCategoryForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CategoryForm();
        });
  }

  void showDeleteCategoryDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteCategoryDialog();
        });
  }
}

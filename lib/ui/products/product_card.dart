import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:zit_sma/main_controller.dart';
import 'package:zit_sma/ui/products/products_controller.dart';
import '../../widgets/animation.dart';

class ProductCard extends StatelessWidget {
  MainController controller = Get.find();
  ProductsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.status.value == Status.initial ||
          _controller.status.value == Status.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _controller.filteredProducts.length,
          itemBuilder: (context, index) {
            var product = _controller.filteredProducts[index];

            return FadeAnimation(
              2,
              Column(
                children: [
                  Obx(() {
                    if (_controller.status == Status.initial ||
                        _controller.status == Status.loading) {
                      return const CircularProgressIndicator();
                    } else {
                      return Slidable(
                        actionPane: const SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption:
                                controller.english.value ? 'Delete' : "حذف",
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () async {
                              _controller.currentProduct(product);
                              await _controller.deleteProduct();
                            },
                          ),
                          IconSlideAction(
                            caption:
                                controller.english.value ? 'Edit' : "تعديل",
                            color: Colors.white,
                            icon: Icons.edit_sharp,
                            onTap: () {
                              _controller.edit(true);
                              _controller.currentProduct(product);
                              _controller.showProductForm(context);
                            },
                          ),
                        ],
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 10,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  _controller.expand.assignAll(List.generate(
                                      _controller.data['data'].length, (i) {
                                    return (i == index)
                                        ? (!_controller.expand[i].value).obs
                                        : false.obs;
                                  }));
                                  _controller.currentProduct(product);
                                },
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(500),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height: MediaQuery.of(context).size.height,
                                    child: Image.network(
                                      'http://vzzoz.pythonanywhere.com${product['Image']}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  product['Name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['Description'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      product['Quantity'].toString(),
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                trailing: Text(
                                  '${product['Price']} SDG',
                                  style:const TextStyle(fontSize: 15),
                                ),
                                isThreeLine: true,
                              ),
                              Obx(() {
                                if (_controller.expand[index].value) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(controller.english.value
                                          ? 'Quantity'
                                          : "الكمية"),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              _controller.decreaseQuantity();
                                            },
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    12,
                                              ),
                                            ),
                                          ),
                                          Obx(() {
                                            return SizedBox(
                                              width: 30,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    TextEditingController(
                                                  text: _controller.newQuantity
                                                      .toString(),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                          TextButton(
                                            onPressed: () {
                                              _controller.increaseQuantity();
                                            },
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              })
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                  Obx(() {
                    if (_controller.expand[index].value) {
                      return Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: TextButton(
                          onPressed: () {
                            _controller
                                .updateQuantity(_controller.newQuantity.value);
                          },
                          child: Text(
                              controller.english.value ? "Finish" : "إنهاء"),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            );
          },
        );
      }
    });
  }
}



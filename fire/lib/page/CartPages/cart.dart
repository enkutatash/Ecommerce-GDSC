import 'package:fire/page/CartPages/cartcontroller.dart';
import 'package:fire/page/CartPages/checkout.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:fire/page/user/Search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;
  Cart(this.userdata, this.userid, {Key? key});

  @override
  Widget build(BuildContext context) {
    final CartController _cartController = Get.find();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Search_Screen(userdata, userid)),
              );
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Cart"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  // Wrap the ListView.builder with Expanded to avoid overflow
                  child: Obx(() {
                    if (_cartController.product.isEmpty) {
                      return const Center(
                        child: Text("Empty cart"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: _cartController.product.length,
                        itemBuilder: (context, index) {
                          final keys = _cartController.product.keys.toList();
                          final values =
                              _cartController.product.values.toList();
                          return CartItem(
                            _cartController,
                            _cartController.product.isNotEmpty
                                ? _cartController.product.keys.toList()[index]
                                : null, // Handle empty map case
                            _cartController.product.isNotEmpty
                                ? _cartController.product.values.toList()[index]
                                : null, // Handle empty map case
                            index,
                          );
                        },
                      );
                    }
                  }),
                ),
                if (_cartController
                    .product.isNotEmpty) // Check if cart is not empty
                  const SizedBox(
                      height: 20), // Add space between ListView and CartTotal
                if (_cartController
                    .product.isNotEmpty) // Check if cart is not empty
                  CartTotal(userid),
                if (_cartController.product.isNotEmpty)
                  CheckoutButton(userdata, userid)
              ],
            )));
  }
}

class CheckoutButton extends StatelessWidget {
  String userid;
  Map<String, dynamic> userdata;
  CheckoutButton(this.userdata, this.userid, {super.key});

  @override
  Widget build(BuildContext context) {
    final CartController _cartController = Get.find();
    final width = MediaQuery.of(context).size.width;
    return Obx(() => _cartController.product.isNotEmpty
        ? SizedBox(
            width: width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                // _cartController.orderCheckOut(userdata);
                // _cartController.clearCart();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckoutPage(userdata,userid)));

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF6055D8)),
              child: const Text(
                "Check Out ",
                style: TextStyle(color: Colors.white),
              ), // Add your button text here
            ),
          )
        : Container());
  }
}

class CartItem extends StatelessWidget {
  final CartController _cartController;
  final Item2 product;
  final int quantity;
  final int index;
  const CartItem(this._cartController, this.product, this.quantity, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0XFFF8F7F7),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
                height: height * 0.13,
                width: width * 0.4,
                fit: BoxFit.cover,
                product.imageURL),
          ),
          Column(
            children: [
              Text(
                product.itemName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${product.cost}')
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    _cartController.delete(product);
                  },
                  icon: const Icon(
                    Icons.delete_sharp,
                    color: Color(0XFFF65A5A),
                    size: 30,
                  )),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _cartController.removeProduct(product);
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Color(0XFF6055D8),
                        size: 30,
                      )),
                  Text('$quantity'),
                  IconButton(
                      onPressed: () {
                        _cartController.addProduct(product);
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0XFF6055D8),
                        size: 30,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  final CartController _cartController;
  final Item2 product;
  final int quantity;
  final int index;
  const CartProduct(
      this._cartController, this.product, this.quantity, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        color: const Color(0XFFF8F7F7),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                  height: height * 0.13,
                  width: width * 0.4,
                  fit: BoxFit.cover,
                  product.imageURL),
            ),
            Column(
              children: [
                Text(
                  product.itemName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${product.cost}')
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      _cartController.delete(product);
                    },
                    icon: const Icon(
                      Icons.delete_sharp,
                      color: Color(0XFFF65A5A),
                      size: 30,
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _cartController.removeProduct(product);
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Color(0XFF6055D8),
                          size: 30,
                        )),
                    Text('${quantity}'),
                    IconButton(
                        onPressed: () {
                          _cartController.addProduct(product);
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Color(0XFF6055D8),
                          size: 30,
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartTotal extends StatelessWidget {
  String userUid;
  CartTotal(this.userUid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController _cartController = Get.find();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(() => _cartController.product.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0XFFF8F7F7),
                borderRadius: BorderRadius.circular(20)),
            height: height * 0.28,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Order Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Items",
                            style: TextStyle(
                                fontSize: 15, color: Color(0XFF484848))),
                        Text("${_cartController.product.length}",
                            style: const TextStyle(
                                fontSize: 15, color: Color(0XFF484848)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("SubTotal",
                            style: TextStyle(
                                fontSize: 15, color: Color(0XFF484848))),
                        Text("\$ ${_cartController.subtotal}",
                            style: const TextStyle(
                                fontSize: 15, color: Color(0XFF484848)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery Charge",
                            style: TextStyle(
                                fontSize: 15, color: Color(0XFF484848))),
                        Text("\$ ${_cartController.delivery}",
                            style: const TextStyle(
                                fontSize: 15, color: Color(0XFF484848)))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 1,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("\$ ${_cartController.total}")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container());
  }
}

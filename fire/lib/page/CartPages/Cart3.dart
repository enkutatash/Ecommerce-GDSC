import 'package:fire/page/CartPages/cartcontroller.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController _cartController = Get.find();
     final height = MediaQuery.of(context).size.height;
    return 
      
    Obx(() => _cartController.product.isEmpty
    ? const Center(
        child: Text("Empty cart"),
      )
    : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.7, // Adjust height as needed
              child: ListView.builder(
                itemCount: _cartController.product.length,
                itemBuilder: (context, index) {
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
              ),
            ),
            // CartTotal()
          ],
        ),
      ),

          );
        }
      }

class CartItem extends StatelessWidget {
  final CartController _cartController;
  final Item2 product;
  final int quantity;
  final int index;
  CartItem(this._cartController, this.product, this.quantity, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0XFFF8F7F7),
      padding: EdgeInsets.all(10),
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
                  icon: Icon(
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
                      icon: Icon(
                        Icons.remove_circle,
                        color: Color(0XFF6055D8),
                        size: 30,
                      )),
                  Text('${quantity}'),
                  IconButton(
                      onPressed: () {
                        _cartController.addProduct(product);
                      },
                      icon: Icon(
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

class CartTotal extends StatelessWidget {
  final CartController _cartController = Get.find();
  CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: 50,
      padding:const EdgeInsets.all(8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Total"), Text("${_cartController.total}")],
                    ),
    );
  }
}
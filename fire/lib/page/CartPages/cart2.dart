import 'package:fire/page/CartPages/cartcontroller.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  final CartController _cartController = Get.find();
  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Cart"),
          centerTitle: true,
        ),
        body: Obx(
          () => _cartController.product.isEmpty
              ? Center(
                  child: Text("Empty cart"),
                )
              : SizedBox(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: _cartController.product.length,
                        itemBuilder: (context, index) {
                          return CartProduct(
                            _cartController,
                            _cartController.product.keys.toList()[index],
                            _cartController.product.values.toList()[index],
                            index,
                          );
                        },
                      ),
                      CartTotal(),
                    ],
                  ),
                ),
        )
        );
  }
}

class CartProduct extends StatelessWidget {
  final CartController _cartController;
  final Item2 product;
  final int quantity;
  final int index;
  CartProduct(this._cartController, this.product, this.quantity, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
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
      ),
    );
  }
}

class CartTotal extends StatelessWidget {
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_cartController) {
        final height = MediaQuery.of(context).size.height;
        return Expanded(
          child: Container(
            height: height * 0.3, // Set a fixed height or adjust as needed
            color: Color(0XFFF8F7F7),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Items"), Text("${_cartController.product.length}")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("SubTotal"), Text("${_cartController.subtotal}")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Delivery Charge"), Text("${_cartController.delivery}")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Total"), Text("${_cartController.total}")],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

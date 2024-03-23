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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => General_Screen()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Cart",
        ),
        centerTitle: true,
      ),
      body:Obx(()=>_cartController.product.isEmpty?const Center(
                  child: Text("Empty cart"),
                ):SizedBox(
                  height:height*0.7
                  ,child: ListView.builder(
                    itemCount: _cartController.product.length,
                    itemBuilder: (context,index){
                      return CartItem(
                            _cartController,
                            _cartController.product.keys.toList()[index],
                            _cartController.product.values.toList()[index],
                            index,
                      ); 
                    }),
                )
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                  height: height * 0.13,
                  width: width * 0.4,
                  fit: BoxFit.cover,
                  product.imageURL),
            ),
            IconButton(
                        onPressed: () {
                          _cartController.removeProduct(product);
                        },
                        icon:const Icon(
                          Icons.remove_circle,
                          color: Color(0XFF6055D8),
                          size: 30,
                        )),
                    Text('$quantity'),
                    IconButton(
                        onPressed: () {
                          _cartController.addProduct(product);
                        },
                        icon:const Icon(
                          Icons.add_circle,
                          color: Color(0XFF6055D8),
                          size: 30,
                        )),
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
    return Container(
      padding:const EdgeInsets.all(8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Total"), Text("${_cartController.total}")],
                    ),
    );
  }
}
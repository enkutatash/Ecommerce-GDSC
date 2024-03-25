import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CollectionReference orderRef =
      FirebaseFirestore.instance.collection('Orders');
  var _product = {}.obs;
  //add product to cart
  void addProduct(Item2 product) {
    if (_product.containsKey(product)) {
      _product[product] += 1;
    } else {
      _product[product] = 1;
    }
    Get.snackbar("Product is added  ", '${product.itemName}',
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 5));
  }

void orderCheckOut(Map<String, dynamic> userdata) {
  
  _product.forEach((product, quantity) {
    orderRef.add({
      'OrderedBy': userdata,
      'Product': {
        'Name': product.itemName,
        'Amount': quantity,
        'Id': product.id,
        'ImageUrl': product.imageURL,
        'Price':product.cost
      },
    });
  });
}


  get product => _product;
  get productSubTotal => _product.entries
      .map((product) => product.key.cost * product.value)
      .toList();

  get subtotal => _product.entries
      .map((product) => product.key.cost * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  // remove product from cart
  void removeProduct(Item2 product) {
    if (_product.containsKey(product) && _product[product] == 1) {
      _product.removeWhere((key, value) => key == product);
    } else {
      _product[product] -= 1;
    }
  }

  void clearCart() {
    _product.clear();
  }

  void delete(Item2 product) {
    _product.removeWhere((key, value) => key == product);
  }

  get delivery => product.length * 0.01;
  get total {
    double subtotal = 0.0;
    product.forEach((item, quantity) {
      subtotal += item.cost * quantity;
    });
    return subtotal + delivery;
  }
}

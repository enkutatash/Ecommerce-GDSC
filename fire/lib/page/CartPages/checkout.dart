import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/page/CartPages/cart.dart';
import 'package:fire/page/CartPages/cartcontroller.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPaymentTile extends StatelessWidget {
  final String paymentMethod;
  final String imagePath;
  final bool isSelected;
  final Function(String) onChanged;

  CustomPaymentTile({
    required this.paymentMethod,
    required this.imagePath,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle1 = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15.0,
      letterSpacing: 0.25,
    );
    TextStyle textStyle = isSelected
        ? customTextStyle1.copyWith(fontWeight: FontWeight.bold)
        : customTextStyle1;

    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 30,
        height: 30,
      ),
      title: Text(
        paymentMethod,
        style: textStyle,
      ),
      trailing: isSelected
          ? Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: Color(0xFF6055D8),
                    ),
                  ),
                ),
              ],
            )
          : null,
      onTap: () {
        onChanged(paymentMethod);
      },
    );
  }
}

class CheckoutPage extends StatefulWidget {
  String userid;
   Map<String, dynamic> userdata;

  CheckoutPage(this.userdata,this.userid, {super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMethod = 'Paypal';

  @override
  Widget build(BuildContext context) {
    final CartController _cartController = Get.find();
    TextStyle customTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      fontSize: 17.0,
      letterSpacing: 0.25,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: customTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xFF6055D8),
                ),
              ),
              title: Text(
                'Current Location',
                style: customTextStyle.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: const Icon(
                  Icons.access_time_filled,
                  color: Color(0xFF6055D8),
                ),
              ),
              title: Text(
                'Current Time',
                style: customTextStyle.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CartTotal(widget.userid),
            Column(
              children: [
                ListTile(
                  title: Text('Choose payment method', style: customTextStyle),
                ),
                CustomPaymentTile(
                  paymentMethod: 'Paypal',
                  imagePath: 'assets/paypal.png',
                  isSelected: selectedPaymentMethod == 'Paypal',
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                CustomPaymentTile(
                  paymentMethod: 'Credit Card',
                  imagePath: 'assets/creditcard.png',
                  isSelected: selectedPaymentMethod == 'Credit Card',
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                CustomPaymentTile(
                  paymentMethod: 'Cash',
                  imagePath: 'assets/cash.png',
                  isSelected: selectedPaymentMethod == 'Cash',
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add new payment method', style: customTextStyle),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Handling the action for adding a new payment method
                  },
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (selectedPaymentMethod == 'Cash') {
             
              _showSuccessAlert(context);
            } else {
              _showCreditCardAlert(context);
            }
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF6055D8)),
            minimumSize:
                MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
          ),
          child: Text(
            'Checkout',
            style: customTextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showCreditCardAlert(BuildContext context) {
    TextEditingController cardNumberController = TextEditingController();
    TextEditingController cvcController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Credit Card Details'),
          content: Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cardNumberController,
                  decoration:
                      const InputDecoration(labelText: 'Credit Card Number'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: cvcController,
                  decoration: const InputDecoration(labelText: 'CVC'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String cardNumber = cardNumberController.text.trim();
                String cvc = cvcController.text.trim();

                if (cardNumber.isEmpty || cvc.isEmpty) {
                  print('Please enter valid credit card details');
                } else {
                  final CartController _cartController = Get.find();

                _cartController.orderCheckOut(widget.userid);
                _cartController.clearCart();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => General_Screen(widget.userdata,widget.userid)));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your payment is successful!'),
          actions: [
            TextButton(
              onPressed: () {
                
                final CartController _cartController = Get.find();

                _cartController.orderCheckOut(widget.userid);
                _cartController.clearCart();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => General_Screen(widget.userdata,widget.userid)));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } 
}

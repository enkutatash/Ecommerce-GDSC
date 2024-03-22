import 'dart:ffi';

import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String imageAsset;
  final String productName;
  final double price;
  final int amount;
  final String size;
  final String id;
  final String description;

  const Details({
    Key? key,
    required this.imageAsset,
    required this.productName,
    required this.price,
    required this.amount,
    required this.size,
    required this.id,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  imageAsset,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 220, 219, 219),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 15,
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 220, 219, 219),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 128, 124, 124),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                  //product name
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      //rateing
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 236, 221, 13),
                            size: 30,
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Text(
                            "(20 review)",
                            style: TextStyle(
                                color: Color.fromARGB(163, 93, 91, 91),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
            //product price
                 Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  '\$$price',
                  style: const TextStyle(
                    color: Color.fromARGB(168, 46, 5, 157),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
              ],
            ),
           
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
             Padding(
              padding:const EdgeInsets.all(8.0),
              child: Text(description
                ,style:const TextStyle(color: Color.fromARGB(255, 102, 102, 101)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyWidget(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: 275,
                    child: ElevatedButton(
                      onPressed: ()  {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 88, 88, 221),
                        ),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 248),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 236, 236),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.work,
                    color: Color.fromARGB(255, 133, 133, 130),
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  bool checkBox1Selected = false;
  bool checkBox2Selected = false;
  bool checkBox3Selected = false;
  bool checkBox4Selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    checkBox1Selected = !checkBox1Selected;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: checkBox1Selected
                          ? Colors.green // Selected color
                          : const Color.fromARGB(255, 182, 182, 182),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '8',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                setState(() {
                  checkBox2Selected = !checkBox2Selected;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: checkBox2Selected
                        ? Colors.green // Selected color
                        : const Color.fromARGB(255, 182, 182, 182),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '10',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                setState(() {
                  checkBox3Selected = !checkBox3Selected;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: checkBox3Selected
                        ? Colors.green // Selected color
                        : const Color.fromARGB(255, 182, 182, 182),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '38',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                setState(() {
                  checkBox4Selected = !checkBox4Selected;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: checkBox4Selected
                        ? Colors.green
                        : const Color.fromARGB(255, 182, 182, 182),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '40',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

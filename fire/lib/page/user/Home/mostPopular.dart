import 'package:fire/page/product/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fire/page/user/Home/Item.dart';
import 'package:fire/page/user/Home/item_on_front_page.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Most Popular",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductList()));
                },
                child: Text(
                  "see all",
                  style: TextStyle(fontSize: 16, color: Color(0XFF6055D8)),
                ),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: mostpopular.entries
                  .map((MapEntry<String, List<dynamic>> entry) {
                String key = entry.key;
                List<dynamic> value = entry.value;
                return Row(
                  children: [
                    Item(value[0], key, value[1], value[2], value[3], value[4],
                        value[5]),
                    const SizedBox(width: 16.0), // Adjust the width as needed
                  ],
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

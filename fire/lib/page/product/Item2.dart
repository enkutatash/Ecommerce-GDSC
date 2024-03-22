import 'package:fire/page/product/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Item2 extends StatefulWidget {
  const Item2(this.imageURL, this.itemName, this.cost, this.Amount,
      this.Description, this.id, this.size,
      {super.key});
  final String imageURL, itemName, Description, id, size;
  final double cost;
  final int Amount;
  @override
  State<Item2> createState() => _Item2State();
}

class _Item2State extends State<Item2> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                    imageAsset: widget.imageURL,
                    productName: widget.itemName,
                    price: widget.cost,
                    amount: widget.Amount,
                    size: widget.size,
                    id: widget.id,
                    description: widget.Description)));
      },
      child: Container(
          height: height * 0.3,
          width: width * 0.4,
          decoration: BoxDecoration(
              color: const Color(0XFFF8F7F7),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                    child: Image.network(
                        height: height * 0.13,
                        width: width * 0.4,
                        fit: BoxFit.cover,
                        widget.imageURL),
                  ),
                  Positioned(
                      top: 7,
                      right: 7,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          size: 30,
                          Icons.favorite_border_sharp,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.itemName,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "\$${widget.cost}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0XFF6055D8),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      size: 30,
                      Icons.add_circle,
                      color: Color(0XFF6055D8),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}

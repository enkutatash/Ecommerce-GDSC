import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item(this.imageURL, this.itemName, this.cost, this.Amount,this.Description,this.id,this.size,{super.key});
  final String imageURL, itemName,Description,id,size;
  final double cost;
  final int Amount;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
          height: height * 0.2,
          width: width * 0.32,
          decoration: BoxDecoration(
              color: const Color(0XFFF8F7F7),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                    child: Image.network(
                        height: height * 0.13,
                        width: width * 0.32,
                        fit: BoxFit.cover,
                        widget.imageURL),
                  ),
                  const Positioned(
                      top: 7,
                      right: 7,
                      child: Icon(
                        size:30,
                        Icons.favorite_border_sharp,
                        color: Colors.white,
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.itemName,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "\$${widget.cost}",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Color(0XFF6055D8),
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          )),
    );
  }
}


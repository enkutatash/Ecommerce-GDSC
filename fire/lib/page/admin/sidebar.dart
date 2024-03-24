import 'package:fire/page/admin/newproduct.dart';
import 'package:fire/page/admin/productedit.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
   Map<String, dynamic> userdata;
  SideBar(this.userdata, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF6055D8),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userdata['profilePic']),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    userdata['userName'],
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add New Product'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewProduct(userdata)));
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Edit Product'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductEditList(userdata,"s6N7ql9YmxdMRu3oC2WDPWQoxvs2")));
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Orders'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

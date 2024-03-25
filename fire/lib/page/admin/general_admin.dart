import 'package:fire/page/admin/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/CartPages/cart.dart';
import 'package:fire/page/admin/sidebar.dart';
import 'package:fire/page/product/product.dart';
import 'package:fire/page/profile/profile.dart';
import 'package:fire/page/user/Home/HomeScreen.dart';
import 'package:fire/page/user/Search/search.dart';

class General_Screen_Admin extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  General_Screen_Admin(this.userdata,this.userid, {Key? key}) : super(key: key);

  @override
  State<General_Screen_Admin> createState() => _General_Screen_AdminState();
}

class _General_Screen_AdminState extends State<General_Screen_Admin> {
  late Firebase_auth_service _auth;
  late Map<String, dynamic> userdata;
  late List<Widget> AllScreens;

  int _selectedScreen = 0;

  
  @override
  void initState() {
    super.initState();
    _auth = Firebase_auth_service(context);
    // Initialize the AllScreens list in initState
    AllScreens = [
      HomeScreen_Admin(widget.userdata, widget.userid),
      Search_Screen(widget.userdata, widget.userid),
      Search_Screen(widget.userdata, widget.userid),
      ProfilePage(widget.userdata, widget.userid),
    ];
  }

  void _currentScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            drawer: SideBar(widget.userdata),
            body: AllScreens[_selectedScreen],
            bottomNavigationBar: BottomNavigationBar(
              onTap: _currentScreen,
              currentIndex: _selectedScreen,
              selectedItemColor: const Color(0xFF6055D8),
              unselectedItemColor: Colors.grey,
              iconSize: 30,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_checkout_outlined),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "",
                ),
              ],
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/CartPages/cart.dart';
import 'package:fire/page/admin/sidebar.dart';
import 'package:fire/page/product/product.dart';
import 'package:fire/page/profile/profile.dart';
import 'package:fire/page/user/Home/HomeScreen.dart';
import 'package:fire/page/user/Search/search.dart';

class General_Screen extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  General_Screen(this.userdata,this.userid, {Key? key}) : super(key: key);

  @override
  State<General_Screen> createState() => _General_ScreenState();
}

class _General_ScreenState extends State<General_Screen> {
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
      HomeScreen(widget.userdata, widget.userid),
      Search_Screen(widget.userdata, widget.userid),
      Cart(widget.userdata, widget.userid),
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
                  icon: Icon(Icons.shopping_bag),
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

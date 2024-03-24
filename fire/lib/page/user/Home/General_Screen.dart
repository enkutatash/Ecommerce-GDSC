import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/CartPages/cart.dart';
import 'package:fire/page/product/product.dart';
import 'package:fire/page/profile/profile.dart';
import 'package:fire/page/user/Home/HomeScreen.dart';
import 'package:fire/page/user/Search/search.dart';
import 'package:flutter/material.dart';

class General_Screen extends StatefulWidget {
  final String userid;
  const General_Screen(this.userid, {super.key});

  @override
  State<General_Screen> createState() => _General_ScreenState();
}

class _General_ScreenState extends State<General_Screen> {
  late Firebase_auth_service _auth;
  late Map<String, dynamic> userdata;

  int _selectedScreen = 0;

  late List<Widget> AllScreens;

  @override
  void initState() {
    super.initState();
    _auth = Firebase_auth_service(context);
    _fetchUserData(widget.userid);
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      userdata = await _auth.data(userId);
      print(userdata['userName']);
      print(userdata['Email']);
      print(userdata['password']);
      print(widget.userid);
      setState(() {
        AllScreens = [
          HomeScreen(userdata, widget.userid),
          Search_Screen(userdata, widget.userid),
          Cart(userdata, widget.userid),
          ProfilePage(userdata, widget.userid),
        ];
      });
    } catch (e) {
      // Handle error
    }
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
        ));
  }
}

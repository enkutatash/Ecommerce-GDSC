import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/admin/general_admin.dart';
import 'package:fire/page/admin/sidebar.dart';
import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:flutter/material.dart';

class AdminFront extends StatefulWidget {
  const AdminFront({super.key});

  @override
  State<AdminFront> createState() => _AdminFrontState();
}

class _AdminFrontState extends State<AdminFront> {
  late Firebase_auth_service _auth;
  late Map<String, dynamic> userdata;
  String userid = "s6N7ql9YmxdMRu3oC2WDPWQoxvs2";

  int _selectedScreen = 0;

  late List<Widget> AllScreens;

  @override
  void initState() {
    super.initState();
    _auth = Firebase_auth_service(context);
    _fetchUserData(userid);
  }

  Future<Map<String, dynamic>> _fetchUserData(String userId) async {
  try {
    final userdata = await _auth.data(userId);
    return userdata; // Return the fetched user data
  } catch (e) {
    // Handle errors
    return Future.error(e); // Or throw an exception
  }
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(userid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userdata = snapshot.data!; // Safe access to userdata
          return Scaffold(
            drawer: SideBar(userdata),
            body: General_Screen_Admin(userdata,"s6N7ql9YmxdMRu3oC2WDPWQoxvs2"),
          );
        } else if (snapshot.hasError) {
          // Handle errors during data fetching (optional)
          return Center(child: Text('Error fetching user data'));
        } else {
          // Show loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


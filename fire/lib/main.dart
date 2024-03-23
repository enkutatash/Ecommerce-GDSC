import 'package:fire/page/user/Home/General_Screen.dart';
import 'package:fire/page/user/Search/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fire/firebase/firebase_options.dart';
import 'package:get/get.dart';
import 'package:fire/page/CartPages/cartcontroller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: General_Screen(),
      ),
    );
  }
}

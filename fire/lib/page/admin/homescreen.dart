import 'package:fire/firebase/firebase_service.dart';
import 'package:fire/page/user/Home/featured.dart';
import 'package:fire/page/user/Home/mostPopular.dart';
import 'package:fire/page/user/Home/updates.dart';
import 'package:fire/page/user/Search/search.dart';
import 'package:flutter/material.dart';

class HomeScreen_Admin extends StatefulWidget {
  Map<String, dynamic> userdata;
  String userid;
  HomeScreen_Admin(this.userdata,this.userid, {super.key});

  @override
  State<HomeScreen_Admin> createState() => _HomeScreen_AdminState();
}

class _HomeScreen_AdminState extends State<HomeScreen_Admin> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: ListView(
      padding:
          EdgeInsets.fromLTRB(width * 0.04, height * 0.003, width * 0.04, 0),
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();
              }
            ,child: CircleAvatar(
                backgroundImage: NetworkImage(widget.userdata['profilePic'])),
          ),
          title: const Text("Hello!"),
          subtitle: Text(
            widget.userdata['userName'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          trailing: CircleAvatar(
              backgroundColor: Color(0XFFF8F7F7),
              child: Icon(Icons.notifications)),
        ),
        SearchBar(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Search_Screen(widget.userdata,widget.userid)));
          },
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 15)),
          backgroundColor:
              const MaterialStatePropertyAll<Color?>(Color(0XFFF8F7F7)),
          shadowColor:
              const MaterialStatePropertyAll<Color?>(Colors.transparent),
          leading: const Icon(Icons.search),
          hintText: "Search here",
          hintStyle: const MaterialStatePropertyAll<TextStyle?>(
              TextStyle(color: Colors.grey, fontSize: 20)),
        ),
        const Updates(),
        FeaturedPart(widget.userdata,widget.userid),
        MostPopular(widget.userdata,widget.userid),
      ],
    ));
  }
}

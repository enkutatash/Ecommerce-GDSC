import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/page/product/Item2.dart';
import 'package:fire/page/user/Home/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    _search.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    print(_search.text);
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (_search.text != "") {
      for (var product in _allResult) {
        var name = product['Name'].toString().toLowerCase();
        if (name.contains(_search.text.toLowerCase())) {
          showResult.add(product);
        }
      }
    } else {
      showResult = List.from(_allResult);
    }
    setState(() {
      _searchResult = showResult;
    });
  }

  List _allResult = [];
  List _searchResult = [];
  getProduct() async {
    var data = await FirebaseFirestore.instance
        .collection('product')
        .orderBy('Name')
        .get();
    setState(() {
      _allResult = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _search.removeListener(_onSearchChange);
    _search.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getProduct();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _search,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width*0.05),
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Results for \"${_search.text!=""?_search.text:"All"}\""),
                Text("\"${_searchResult.length}\" Results found",style: TextStyle(color: Color(0XFF6055D8)),)
              ],
             ),
           )
            ,Expanded(
              child: GridView.builder(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing: width*0.03, // Spacing between columns
                          mainAxisSpacing: 10.0, // Spacing between rows
                        ),
                  itemCount: _searchResult.length,
                  itemBuilder: (context, index) {
                    String name =  _searchResult[index]['Name'];
                    double price =  _searchResult[index]['Price'];
                    int amount =  _searchResult[index]['Amount'];
                    String description =  _searchResult[index]['Desciption'];
                    String imageURL =  _searchResult[index]['ImageUrl'];
                    String id =  _searchResult[index]['Id'];
                    String size =  _searchResult[index]['Size'];
                    return Item2(imageURL, name, price, amount, description, id, size);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

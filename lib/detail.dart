import 'dart:convert';
import 'package:aas_0076/style.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'login_page.dart';

class DetailPage extends StatelessWidget {
  final String apiUrl = "https://dummyjson.com/products";
  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body)['products'];
  }

  final int index;

  DetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromRGBO(242, 102, 100, 1),
        title: Text('Product Detail'),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20, top: 5),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              icon: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Container(
          child: FutureBuilder<List<dynamic>>(
              future: _fecthDataUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            snapshot.data[index]['thumbnail'],
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 20, bottom: 5, left: 30),
                            child: Text(
                              snapshot.data[index]['title'],
                              style: titleFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 30, right: 30, left: 30),
                            child: Text(
                              snapshot.data[index]['description'],
                              style: catFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, left: 30),
                            child: Text(
                              "Category : " + snapshot.data[index]['category'],
                              style: catFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, bottom: 30),
                            child: Text(
                              "Brand : " + snapshot.data[index]['brand'],
                              style: catFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, bottom: 5),
                            child: Text(
                              "Price : " +
                                  snapshot.data[index]['price'].toString() +
                                  " Dollars",
                              style: catFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, bottom: 5),
                            child: Text(
                              "Rating : " +
                                  snapshot.data[index]['rating'].toString(),
                              style: catFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, bottom: 5),
                            child: Text(
                              "Stock : " +
                                  snapshot.data[index]['stock'].toString(),
                              style: catFont,
                            ),
                          ),
                          Center(
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 40, right: 32, left: 32),
                              height: 80,
                              width: 200,
                              margin: EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }));
                                },
                                child: Text(
                                  'Add to Cart',
                                  style: bt_signup,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  primary: Color.fromRGBO(242, 102, 100, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}

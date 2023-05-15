import 'dart:io';

import 'package:apiloginproject/Splasscreen.dart';
import 'package:apiloginproject/main.dart';
import 'package:apiloginproject/viewproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'addproduct.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int cnt = 0;
  String? name;
  String? email;
  String? imagepath;

  List<Widget> list = [viewproduct(), addproduct()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = splashpage.prefrs!.getString("Name");
    email = splashpage.prefrs!.getString("Email");
    imagepath = splashpage.prefrs!.getString("image");

    print("====$imagepath");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: list[cnt],
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: Image.network(
                  "https://chetansheladiya.000webhostapp.com/apicalling/$imagepath"),
              accountName: Text(
                "$name",
                style: TextStyle(fontSize: 25),
              ),
              accountEmail: Text("$email")),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                cnt = 0;
              });
            },
            leading: Icon(
              Icons.shopping_cart,
            ),
            title: Text("View Product"),
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                cnt = 1;
              });
            },
            leading: Icon(
              Icons.shopping_cart,
            ),
            trailing: Icon(Icons.arrow_right),
            title: Text("Add Product"),
          ),
          ListTile(
            onTap: () {

              splashpage.prefrs!.setBool("loginstatus", false);
              Future.delayed(Duration(seconds: 4)).then((value) {
                EasyLoading.show(status: "Log Out Sucessful");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return firstpage();
                },));
              });
            },
            leading: Icon(
              Icons.logout,
            ),
            trailing: Icon(Icons.arrow_right),
            title: Text("Log Out"),
          ),
        ],
      )),
      backgroundColor: Colors.orange,
    );
  }
}

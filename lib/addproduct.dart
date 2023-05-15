import 'dart:convert';
import 'dart:io';
import 'package:apiloginproject/Homepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:apiloginproject/Splasscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  TextEditingController adname = TextEditingController();
  TextEditingController proprice = TextEditingController();
  TextEditingController despro = TextEditingController();

  String image = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white30,
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            elevation: 50,
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 3, color: Colors.orange),
                                  image: DecorationImage(
                                    image: AssetImage("images/bb.webp"),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black54, BlendMode.darken),
                                  ),
                                ),
                                height: 200,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(17),
                                      child: InkWell(
                                        onTap: () async {
                                          final ImagePicker _picker =
                                              ImagePicker();
                                          XFile? abc = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          setState(() {
                                            image = abc!.path;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[500]
                                                ?.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                width: 2, color: Colors.orange),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.image,
                                                  size: 40,
                                                  color: Colors.white),
                                              Text(
                                                "Browse Gallery",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "OR",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          decoration: TextDecoration.underline),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final ImagePicker _picker =
                                            ImagePicker();
                                        XFile? aaa = await _picker.pickImage(
                                            source: ImageSource.camera);
                                        setState(() {
                                          image = aaa!.path;
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[500]
                                              ?.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              width: 2, color: Colors.orange),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Use a Camera",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        child: CircleAvatar(
                            backgroundImage: FileImage(File(image)),
                            radius: 80),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(top: 30),
                      child: TextField(
                        controller: adname,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 20,
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter Product name"),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      margin: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: proprice,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 20,
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter Product Price"),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      margin: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: despro,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 20,
                                borderRadius: BorderRadius.circular(20)),
                            hintText: "Enter Product Description"),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        EasyLoading.show(status: "Please wait");
                        String name = adname.text;
                        String price = proprice.text;
                        String des = despro.text;
                        String? id = splashpage.prefrs!.getString("id");

                        List<int> iii = File(image).readAsBytesSync();
                        String imagedata1 = base64Encode(iii);

                        Map Map2 = {
                          "Productname": name,
                          "Productprice": price,
                          "desctription": des,
                          "proimage": imagedata1,
                          "loginid": id,
                        };
                        var url = Uri.parse(
                            'https://chetansheladiya.000webhostapp.com/apicalling/Addproduct.php');
                        var response = await http.post(url, body: Map2);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        var ss =jsonDecode(response.body);
                        addproductclass kk=addproductclass.fromJson(ss);
                        print("======$ss");
                        if(kk.connection==1)
                          {
                            if(kk.result==1)
                              {
                                EasyLoading.dismiss(animation: false);
                                EasyLoading.showSuccess("Add Product sucessfully",);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                 return Homepage();
                                },));
                              }
                          }
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: size.height * 0.08,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                              topRight: Radius.circular(80),
                              bottomLeft: Radius.circular(80)),
                          gradient: LinearGradient(
                              colors: [Color(0xff574e37), Color(0xffe3a90b)]),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: 60, right: 60),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}


class addproductclass {
  int? connection;
  int? result;

  addproductclass({this.connection, this.result});

  addproductclass.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}

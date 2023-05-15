import 'dart:convert';
import 'package:apiloginproject/updatepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:apiloginproject/Homepage.dart';
import 'package:apiloginproject/Splasscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Productview.dart';

class viewproduct extends StatefulWidget {
  const viewproduct({Key? key}) : super(key: key);

  @override
  State<viewproduct> createState() => _viewproductState();
}

class _viewproductState extends State<viewproduct> {
  viewproclass? nn;
  bool kk = false;
  deleteid? ff;

  List<viewproclass> productdata = [];
  String image="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tranferview();
  }

  Future<void> tranferview() async {
    String? userid = splashpage.prefrs!.getString("id");
    Map mapview = {
      "loginid": userid,
    };

    var url = Uri.parse(
        'https://chetansheladiya.000webhostapp.com/apicalling/viewproduct.php');
    var response = await http.post(url, body: mapview);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mn = jsonDecode(response.body);

    nn = viewproclass.fromJson(mn);

    if (nn!.connection == 1) {
      if (nn!.result == 1) {
        setState(() {
          kk = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return kk
        ? Scaffold(
      //backgroundColor: Colors.blue,
      body: SlidableAutoCloseBehavior(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 2.5),
          itemCount: nn!.productdata!.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Share',
                    ),
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Archive',
                    ),
                  ]),
              endActionPane: ActionPane(motion: BehindMotion(),
                  children: [SlidableAction(
                    onPressed: (context) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return updatepage(nn!.productdata![index]);
                    },));
                    },
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'Update',
                  ), SlidableAction(
                    onPressed: (context) async {
                      EasyLoading.show(status: "Loading.....");
                      String? idnumber=nn!.productdata![index].id;
                      Map del={"userid":idnumber};

                      print("================$del");
                      var url = Uri.parse('https://chetansheladiya.000webhostapp.com/apicalling/Deleteproduct.php');
                      var response = await http.post(url, body: del);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      var jj= jsonDecode(response.body);
                      ff =deleteid.fromJson(jj);
                      if(ff!.connection==1){
                        if(ff!.result==1)
                          {

                            setState(() {
                              tranferview();
                            });
                            EasyLoading.dismiss(
                                animation: false);

                            EasyLoading.showSuccess(
                                "Delete successfully");
                          }
                      }

                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  ]),
              child: InkWell(onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return productviewpage(nn!.productdata![index]);
                },));
              },
                child: Column(
                  children: [
                    Card(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Card(
                                child: Container(margin: EdgeInsets.only(bottom: 10),
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.1,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.36,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://chetansheladiya.000webhostapp.com/apicalling/"
                                                  "${nn!.productdata![index]
                                                  .proimage}"),
                                        ))),
                              ),
                              Text("id${nn!.productdata![index].id}")
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.15,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.5,
                            child: ListTile(
                              title: Text(
                                "${nn!.productdata![index].productname}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Description"
                                        " ${nn!.productdata![index].desctription}",
                                  ),

                                  Text(
                                    "Rs.${nn!.productdata![index].productprice}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    )
        : CircularProgressIndicator();
  }
}

class viewproclass {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  viewproclass({this.connection, this.result, this.productdata});

  viewproclass.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? productname;
  String? productprice;
  String? desctription;
  String? proimage;
  String? userid;

  Productdata({this.id,
    this.productname,
    this.productprice,
    this.desctription,
    this.proimage,
    this.userid});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['Productname'];
    productprice = json['Productprice'];
    desctription = json['desctription'];
    proimage = json['proimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Productname'] = this.productname;
    data['Productprice'] = this.productprice;
    data['desctription'] = this.desctription;
    data['proimage'] = this.proimage;
    data['userid'] = this.userid;
    return data;
  }
}
class deleteid {
  int? connection;
  int? result;

  deleteid({this.connection, this.result});

  deleteid.fromJson(Map<String, dynamic> json) {
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


// https://chetansheladiya.000webhostapp.com/apicalling/viewproduct.php

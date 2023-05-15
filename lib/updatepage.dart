import 'dart:convert';
import 'dart:io';
import 'package:apiloginproject/Homepage.dart';
import 'package:apiloginproject/Splasscreen.dart';
import 'package:apiloginproject/viewproduct.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class updatepage extends StatefulWidget {
  Productdata productdata;
 updatepage(this.productdata);




  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  update? uu;

  TextEditingController upname= TextEditingController();
  TextEditingController upproprice= TextEditingController();
  TextEditingController updespro= TextEditingController();

  String upimage="";
var spinkit;
  int a=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upname.text=widget.productdata.productname!;
    upproprice.text=widget.productdata.productprice!;
    updespro.text=widget.productdata.desctription!;

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBar(title: Text("Update product"),),
        body: ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: InkWell(onTap:() {
                  setState(() {
                    a=1;
                  });
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
                            border: Border.all(width: 3,color: Colors.orange),
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
                                    final ImagePicker _picker = ImagePicker();
                                    XFile? abc = await _picker.pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      upimage = abc!.path;
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
                                          width: 2,
                                          color: Colors.orange),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
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
                                    decoration:
                                    TextDecoration.underline),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  XFile? aaa = await _picker.pickImage(source: ImageSource.camera);
                                  setState(() {
                                    upimage= aaa!.path;
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
                                        width: 2,
                                        color: Colors.orange),
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
                  child:a==1? CircleAvatar(
                      backgroundImage: FileImage(File(upimage)),radius: 80):
                  CircleAvatar(radius: 80,
                      backgroundImage: NetworkImage("https://chetansheladiya.000webhostapp.com/apicalling/"
                          "${widget.productdata.proimage}")),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 50,width: 300,
                  margin: EdgeInsets.only(top: 30),
                  child: TextField(controller: upname,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(gapPadding: 20,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter Product name"),
                  ),
                ),
                Container(
                  height: 50,width: 300,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(controller: upproprice,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(gapPadding: 20,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter Product Price"),
                  ),
                ),

                Container(
                  height: 100,width: 300,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(controller: updespro,maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(gapPadding: 20,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Enter Product Description"),
                  ),
                ),
                InkWell(onTap: () async {
                  EasyLoading.show(status: "Please wait");
                  String imagedata1="";
                  if(upimage!=""){
                    List<int> iii = File(upimage).readAsBytesSync();
                     imagedata1 = base64Encode(iii);
                  }


                   String? image1 = widget.productdata.proimage;
                  Map Map3={
                    "Productname":upname.text,
                    "Productprice":upproprice.text,
                    "desctription":updespro.text,
                    "proimage":imagedata1,
                    "imagenew":image1,
                    "loginid":widget.productdata.id,
                  };

                  print("======$Map3");
                  var url = Uri.parse('https://chetansheladiya.000webhostapp.com/apicalling/update.php');
                  var response = await http.post(url, body: Map3);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  var up=jsonDecode(response.body);
                  uu=update.fromJson(up);
                  if(uu!.connection==1)
                    {
                      if(uu!.result==1)
                        {
                          EasyLoading.dismiss(animation: false);
                          EasyLoading.showSuccess("Update sucessfully",);
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                          bottomLeft: Radius.circular(80)
                      ),
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


class update {
  int? connection;
  int? result;

  update({this.connection, this.result});

  update.fromJson(Map<String, dynamic> json) {
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

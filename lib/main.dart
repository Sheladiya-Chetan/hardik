import 'dart:convert';

import 'package:apiloginproject/try.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';
import 'Splasscreen.dart';
import 'listdropdown.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home:
          //login()
      splashpage()
      ,
       //   firstpage()
  ));
  splashpage.easyload();
}

const double width = 320;
const double height = 480;

class firstpage extends StatefulWidget {


  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var email1 = "";
  var password1 = "";

  clearText() {
    email.clear();
    password.clear();
  }


  bool vis = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginclass();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                image: AssetImage("images/bb2.jpeg"))),
        child: ListView(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                  child: Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "a1",
                    fontSize: 80,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black54,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.7),
                            blurRadius: 30,
                            offset: Offset(25, 25),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(children: [
                        Container(
                            height: 150,
                            child: Lottie.asset(
                              'images/aaa3.json',
                            )),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                    gapPadding: 10,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Enter Your Email",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Icon(
                                      FontAwesomeIcons.envelope,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  )),
                              validator: (value) {
                                // if (value!.isEmpty ||
                                //     !RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
                                //         .hasMatch(value!)) {
                                //   return "Enter Your Corret Email";
                                // } else {
                                //   return null;
                                // }
                              },
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: password,
                              obscureText: vis,
                              autocorrect: true,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    gapPadding: 10,
                                  ),
                                  hintText: "Enter Your Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(vis
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        vis = !vis;
                                      });
                                    },
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Icon(
                                      FontAwesomeIcons.lock,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  )),
                              // validator: (value) {
                              // if(value == null || value.isEmpty){
                              //   return "Please Enter Password";
                              // }
                              // return null;
                              // }

                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Forgate Password ?",
                              style: TextStyle(
                                  color: Colors.white30, fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        InkWell(
                          onTap: () {},
                          child: InkWell(
                            onTap: () async {
                              String email1 = email.text;
                              String password1 = password.text;

                              Map map1 = {
                                "Email": email1,
                                "Password": password1
                              };

                              var url = Uri.parse(
                                  'https://chetansheladiya.000webhostapp.com/apicalling/login.php');
                              var response = await http.post(url, body: map1);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');


                              var dd = jsonDecode(response.body);

                              myclassdatafirst jj = myclassdatafirst.fromJson(dd);

                              if (jj.connection == 1) {
                                if (jj.result == 1) {


                                  String? ide = jj.userdata!.id;
                                  String? namee = jj.userdata!.name;
                                  String? emaile = jj.userdata!.email;
                                  String? dobe = jj.userdata!.dOB;
                                  String? coursee = jj.userdata!.course;
                                  String? passworde = jj.userdata!.password;
                                  String? imagee=jj.userdata!.image;

                                  splashpage.prefrs!.setBool("loginstatus", true);

                                  splashpage.prefrs!.setString("id", ide!);
                                  splashpage.prefrs!.setString("Name", namee!);
                                  splashpage.prefrs!.setString("Email", emaile!);
                                  splashpage.prefrs!.setString("DOB", dobe!);
                                  splashpage.prefrs!.setString("Course", coursee!);
                                  splashpage.prefrs!.setString("Password", passworde!);
                                  splashpage.prefrs!.setString("image", imagee!);

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return Homepage();
                                    },
                                 ));
                                }
                              }
                            },
                            child: Container(
                              height: size.height * 0.07,
                              width: size.width * 0.7,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                gradient: LinearGradient(colors: [
                                  Color(0xff4ba9db),
                                  Color(0xff03193d)
                                ]),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 60, right: 60),
                                child: Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        //fontFamily: "a1",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Divider(
                height: 2,
                thickness: 3,
                color: Colors.white30,
                indent: 40,
                endIndent: 40,
              )
            ],
          ),
          SizedBox(height: 8),
          Center(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Image(
                      image: AssetImage(
                        "images/g1.png",
                      ),
                      width: 30,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Image(
                      image: AssetImage(
                        "images/applenew.png",
                      ),
                      width: 30,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Image(
                      image: AssetImage(
                        "images/newff.png",
                      ),
                      width: 30,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          "Don't have an account.?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return login();
                            },
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ))
        ]),
      ),
    );
  }





  // Future<void> loginclass() async {
  //   splashpage.prefrs = await SharedPreferences.getInstance();
  //   setState(() {
  //     Islogin = splashpage.prefrs!.getBool("loginstatus") ?? false;
  //   });
  //   if (Islogin) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //       builder: (context) {
  //         return Homepage();
  //       },
  //     ));
  //   } else {
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //       builder: (context) {
  //         return firstpage();
  //       },
  //     ));
  //   }
  // }
}


class myclassdatafirst {
  int? connection;
  int? result;
  Userdata? userdata;

  myclassdatafirst({this.connection, this.result, this.userdata});

  myclassdatafirst.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? email;
  String? dOB;
  String? course;
  String? password;
  String? image;

  Userdata(
      {this.id,
        this.name,
        this.email,
        this.dOB,
        this.course,
        this.password,
        this.image});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    email = json['Email'];
    dOB = json['DOB'];
    course = json['Course'];
    password = json['Password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['DOB'] = this.dOB;
    data['Course'] = this.course;
    data['Password'] = this.password;
    data['image'] = this.image;
    return data;
  }
}



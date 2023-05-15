import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'Homepage.dart';
import 'main.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String image = "";
  final List<String> items = [
    '10th',
    '12th',
    'B.B.A',
    'M.B.A',
    'Other Qualification'
  ];
  bool vis = true;

  TextEditingController nameee = TextEditingController();
  TextEditingController emailee = TextEditingController();
  TextEditingController passwordee = TextEditingController();
  TextEditingController dobee = TextEditingController();
  TextEditingController coursee = TextEditingController();
  TextEditingController imagee = TextEditingController();

  clearText() {
    nameee.clear();
    emailee.clear();
    passwordee.clear();
  }

  List dropDownListData = [
    {"title": "BCA", "value": "1"},
    {"title": "MCA", "value": "2"},
    {"title": "B.Tech", "value": "3"},
    {"title": "M.Tech", "value": "4"},
  ];

  String Defultvalue = "";
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          image: AssetImage("images/bb2.jpeg"),
        )),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(children: [
                Container(
                  padding: EdgeInsets.only(top: 70),
                  child: Center(
                      child: Text(
                    "Sign up",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  )),
                ),
                Row(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      //width: size.width*0.2,
                      margin: EdgeInsets.only(left: 100, top: 20),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(image)),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                elevation: 50,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 5),
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
                                                    width: 2,
                                                    color: Colors.black),
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
                                            final ImagePicker _picker =
                                                ImagePicker();

                                            XFile? abc =
                                                await _picker.pickImage(
                                                    source: ImageSource.camera);
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
                                                  width: 2,
                                                  color: Colors.black),
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
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 110, top: 60),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.teal,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[500]?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: TextFormField(
                            controller: nameee,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Your Name",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                )),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[500]?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: TextFormField(
                            controller: emailee,
                            decoration: InputDecoration(
                                labelText: "Email",
                                border: InputBorder.none,
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
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[500]?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextField(
                            controller: dobee,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today,
                                    color: Colors.white),
                                labelText: "Enter Date of Birth",
                                labelStyle: TextStyle(fontSize: 20)),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(formattedDate);

                                setState(() {
                                  dobee.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[500]?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextField(
                          controller: coursee,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            //fillColor: Colors.lightBlue.shade50,
                            filled: true,
                            hintText: 'Qualification',
                            prefixIcon: Icon(
                              Icons.list_alt_outlined,
                              color: Colors.white,
                            ),
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                coursee.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return items
                                    .map<PopupMenuItem<String>>((String value) {
                                  return new PopupMenuItem(
                                      child: new Text(value), value: value);
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[500]?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: TextFormField(
                            controller: passwordee,
                            obscureText: vis,
                            autocorrect: true,
                            decoration: InputDecoration(
                                labelText: "Password",
                                border: InputBorder.none,
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
                            // if (value.isEmpty) return "Password can't be empty";
                            // if (value.length < 8) return "Password lenght must have >=8";
                            // return null;

                            style: TextStyle(fontSize: 20, color: Colors.white),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    String name = nameee.text;
                    String email = emailee.text;
                    String dob = dobee.text;
                    String course = coursee.text;
                    String password = passwordee.text;

                    List<int> iii = File(image).readAsBytesSync();
                    String imagedata = base64Encode(iii);

                    Map map = {
                      "name": name,
                      "email": email,
                      "dob": dob,
                      "course": course,
                      "password": password,
                      "imagedata": imagedata
                    };
                    var url = Uri.parse(
                        'https://chetansheladiya.000webhostapp.com/apicalling/data.php');
                    var response = await http.post(url, body: map);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    var ff = jsonDecode(response.body);

                    rasigster hh = rasigster.fromJson(ff);
                    if (hh.connection == 1) {
                      if (hh.result == 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Register Successfully")));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return firstpage();
                        },));
                      } else if (hh.result == 2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Already Exist")));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return firstpage();
                        },));
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: size.height * 0.08,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80)),
                      gradient: LinearGradient(
                          colors: [Color(0xff349beb), Color(0xff03193d)]),
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
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class rasigster {
  int? connection;
  int? result;

  rasigster({this.connection, this.result});

  rasigster.fromJson(Map<String, dynamic> json) {
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

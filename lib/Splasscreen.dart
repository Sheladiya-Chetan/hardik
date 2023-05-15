import 'package:apiloginproject/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class splashpage extends StatefulWidget {
  static SharedPreferences? prefrs;

  static void easyload() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.backgroundColor = Colors.brown[900];
    EasyLoading.instance.textColor = Colors.white;
    EasyLoading.instance.indicatorColor = Colors.white;
    EasyLoading.instance.indicatorSize = 40;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.dualRing;
    EasyLoading.instance.animationDuration = Duration(seconds: 1);
  }

  @override
  State<splashpage> createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  bool loginaaa=false;

  @override
  void initState() {
    super.initState();
    sherpp();

  }

  Future<void> sherpp() async {
    splashpage.prefrs = await SharedPreferences.getInstance();
    setState(() {
      loginaaa=splashpage.prefrs!.getBool("loginstatus")??false;
      print ("===${loginaaa}");
    });
    Future.delayed(Duration(seconds: 5)).then((value) {
      if(loginaaa){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Homepage();},));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return firstpage();},));
      }
    },);

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child:Lottie.asset("images/54350-online-shopping-delivery.json"),
        ),
      ),
    );
  }


}

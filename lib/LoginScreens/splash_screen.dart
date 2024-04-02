import 'dart:async';


import 'package:abbas/LoginScreens/starting_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/Home.dart';
import '../main.dart';



class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  Future<void>checkuserlogin()async
  {
    final preferences=await SharedPreferences.getInstance();
     final userStatus=preferences.getBool(keyValue);
    Future.delayed(const  Duration(seconds: 5),(){
      if(userStatus==null||userStatus==false)
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const  Starting_Screen()));
      }
      else
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage()));
      }
    });}


  @override
  void initState() {
    checkuserlogin();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splashscreen.png',height: mheight * 0.45,
          width: mwidth * 0.81),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
import 'package:flutter/material.dart';

import 'login_page.dart';


class Starting_Screen extends StatefulWidget {
  const Starting_Screen({Key? key}) : super(key: key);

  @override
  State<Starting_Screen> createState() => _Starting_ScreenState();
}

class _Starting_ScreenState extends State<Starting_Screen> {
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor:  Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.06,top: mheight*0.045),
                child: const Text(
                  'Hello!',
                  style: TextStyle(
                      color: Color(0xff00B69D),
                      fontSize: 30,fontFamily: 'title',
                      fontWeight: FontWeight.w700),
                ),
              ), SizedBox(
                height: mheight * 0.06,
              ),
              // Center(
              //   child: Lottie.asset('Animation/startingscreen.json',
              //       repeat: false,
              //       reverse: true,
              //       fit: BoxFit.cover,
              //       height: mheight * 0.45),
              // ),
              SizedBox(
                height: mheight * 0.005,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.078),
                child: const  Text(
                  'Find Your Pet With Us',
                  style: TextStyle(
                      color: Color(0xff00B69D),
                      fontSize: 23,fontFamily: 'title',
                      fontWeight: FontWeight.w700),
                ),
              ),SizedBox(
                height: mheight * 0.023,
              ),
              Padding(
                padding: EdgeInsets.only(left: mwidth * 0.078),
                child: const  Text(
                  'Join And Discover The Best Pet In Your\n Location ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,fontFamily: 'title',
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: mheight * 0.12,
              ),
              Center(
                child: TextButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>const Login_Page())),
                  child:  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff0E697C),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: mwidth * 0.32,
                    height: mheight * 0.05,
                    child: const Center(
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'title',
                        ),
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ));
  }
}

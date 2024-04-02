import 'dart:developer';
import 'dart:io';


import 'package:abbas/LoginScreens/phonelogin.dart';
import 'package:abbas/LoginScreens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/Home.dart';
import '../main.dart';
import '../toast_message.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

TextEditingController loginPageEmail = TextEditingController();
TextEditingController loginPagePassword = TextEditingController();
String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";
final form_key = GlobalKey<FormState>();
String loginpage_email1 = '';
String loginpage_password1 = '';
bool passwordvisible = false;
bool isLoading = false;
FirebaseAuth auth = FirebaseAuth.instance;

class _Login_PageState extends State<Login_Page> {
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await auth.signInWithCredential(credential);
    } catch (e) {
      //show error toast message here
      log('\n_signInWithGoogle: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    RegExp regex = RegExp(pattern);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mheight * 0.026,
            ),
            SizedBox(
              height: mheight * 0.06,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>  HomePage())),
                child: Row(
                  children: [
                    SizedBox(
                      width: mwidth * 0.86,
                    ),
                    Text(
                      'Skip',
                      style: TextStyle(
                          color: Color(0xffA0A0A0),
                          fontWeight: FontWeight.w300),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xffA0A0A0),
                      size: size.width*0.035,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mheight * 0.0185,
            ),
            Image.asset(
              'assets/login.png',
              height: mheight * 0.25,
              width: mwidth * 0.5,
            ),
            SizedBox(
              height: mheight * .015,
            ),
            Text(
              'Time to spread your love',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff00B69D),
                  fontFamily: 'title'),
            ),
            SizedBox(
              height: mheight * 0.02,
            ),
            Text(
              'Sign In',
              style: TextStyle(
                  color: Color(0xff0E697C),
                  fontSize: 31,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'title'),
            ),
            SizedBox(
              height: mheight * 0.015,
            ),
            Form(
                key: form_key,
                child: Column(children: [
                  Center(
                    child: Card(
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: mwidth * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: mwidth * 0.9,
                        height: mheight * 0.07,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: mwidth * 0.05),
                              child: SizedBox(
                                height: mheight * 0.028,
                                width: mwidth * 0.072,
                                child: Image.asset(
                                  'assets/email.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: mwidth * 0.04, top: mheight * 0.004),
                              width: mwidth * 0.756,
                              height: mheight * 0.08,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: loginPageEmail,
                                onSaved: (value) {
                                  loginpage_email1 = value!;
                                  loginpage_email1 = value!.trim();
                                  value.replaceAll(RegExp(r'\s+'), '');
                                },onChanged: (value) {

                                loginPageEmail.value = TextEditingValue(
                                  text: value.trim(),
                                  selection:  loginPageEmail.selection,
                                );
                              },

                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: Color(0xff7DAEB8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'title')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mheight * 0.015,
                  ),
                  Center(
                    child: Card(
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: mwidth * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: mwidth * 0.9,
                        height: mheight * 0.07,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: mwidth * 0.05),
                              child: SizedBox(
                                height: mheight * 0.028,
                                width: mwidth * 0.072,
                                child: Image.asset(
                                  'assets/password.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: mwidth * 0.04, top: mheight * 0.02),
                              width: mwidth * 0.756,
                              height: mheight * 0.08,
                              child: TextFormField(
                                obscureText: passwordvisible ? false : true,
                                textInputAction: TextInputAction.done,
                                controller: loginPagePassword,
                                validator: (value) {
                                  if (value == null ||
                                      value.length < 6 ||
                                      value.isEmpty) {
                                    return 'Password should be atleast 6 character';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  loginpage_password1 = value!;
                                },
                                decoration: InputDecoration(
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            passwordvisible = !passwordvisible;
                                          });
                                        },
                                        icon: passwordvisible
                                            ? Icon(
                                                Icons.remove_red_eye,
                                                color: Color(0xff95BDC6),
                                                size: size.width*0.04,
                                              )
                                            : Icon(
                                                FontAwesomeIcons.eyeSlash,
                                                color: Color(0xff95BDC6),
                                                size: 14,
                                              )),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Color(0xff7DAEB8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'title')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: mwidth * 0.58,
                      ),
                      TextButton(
                        onPressed: () => (),
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //         builder: (BuildContext a) => ForgetPassword())),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Color(0xffA0A0A0),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'title'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mheight * 0.0135,
                  ),
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : TextButton(
                            onPressed: () async {
                              final isvalid = form_key.currentState?.validate();
                              if (isvalid == true) {
                                form_key.currentState?.save();
                                setState(() {
                                  isLoading = true; // Show progress indicator
                                });
                                try {
                                  await auth.signInWithEmailAndPassword(
                                    email: loginPageEmail.text,
                                    password: loginPagePassword.text,
                                  );
                                  final preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setBool(keyValue, true);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                             HomePage()),
                                  );
                                } catch (error) {
                                  ToastMessage()
                                      .toastmessage(message: error.toString());
                                } finally {
                                  setState(() {
                                    isLoading =
                                        false; // Hide progress indicator
                                  });
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff0E697C),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: mwidth * 0.32,
                              height: mheight * 0.05,
                              child: const Center(
                                child: Text(
                                  'LOG IN',
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
                  SizedBox(
                    height: mheight * 0.04,
                  ),
                  Text("Or Sign up using",style: TextStyle(fontSize: 15,fontFamily: "title",color: Color(0xffA0A0A0)),),


                  SizedBox( height: mheight * 0.02,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _signInWithGoogle()
                              .then((value) {
                                String username=value!.additionalUserInfo!.profile!['given_name'].toString();
                                String image=value!.additionalUserInfo!.profile!['picture'].toString();
                                userInfo(username,image);
                                print(value);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => HomePage()));})
                              .onError((error, stackTrace) => ToastMessage()
                                  .toastmessage(message: error.toString()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: mheight * 0.04,
                              width: mwidth * 0.09,
                              color: Colors.white,
                              child: Image.asset("assets/google.png"),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: mwidth * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => Phonelogin()));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: mheight * 0.04,
                              width: mwidth * 0.10,
                              color: Colors.white,
                              child: Icon(MdiIcons.phone,color: Color(0xff2FB44B)),
                            ),
                            SizedBox(
                              width: mwidth * 0.02,
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mheight * 0.0175,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: mwidth * 0.18,
                      ),
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(
                            color: Color(0xff484848),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'title'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const Signup_Page()));
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(
                              color: Color(0xff0E697C),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'title'),
                        ),
                      )
                    ],
                  )
                ])),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
        ),
      ),
    );
  }
  void userInfo( String username, String image) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('Username', username);
    await preferences.setString('Image', image);

  }
  @override
  void dispose() {
    loginPageEmail.clear();
    loginPagePassword.clear();
    super.dispose();
  }
}

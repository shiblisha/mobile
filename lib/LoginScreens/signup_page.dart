import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/Home.dart';
import '../main.dart';
import '../toast_message.dart';
import 'login_page.dart';

class Signup_Page extends StatefulWidget {
  const Signup_Page({Key? key}) : super(key: key);

  @override
  State<Signup_Page> createState() => _Signup_PageState();
}

TextEditingController signupPageEmail = TextEditingController();
TextEditingController signupPagePassword = TextEditingController();
TextEditingController userName = TextEditingController();
String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";
final form_key = GlobalKey<FormState>();
String signuppage_email1 = '';
String signuppage_password1 = '';
String username1 = '';
bool passwordvisible = false;
bool isLoading = false;

class _Signup_PageState extends State<Signup_Page> {
  Future<User?> createAccount(
      String name, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCrendetial = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final preferences = await SharedPreferences.getInstance();
      preferences.setBool(keyValue, true);
      ToastMessage().toastmessage(message: 'Successfully Registered');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) =>  HomePage()),
      );

      print("Account created Succesfull");
//create a username like this
      userCrendetial.user!.updateDisplayName(name);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "status": "Unavalible",
        "uid": _auth.currentUser!.uid,
      });

      return userCrendetial.user;
    } catch (error) {
      ToastMessage().toastmessage(message: error.toString());
    } finally {
      setState(() {
        isLoading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    FirebaseAuth auth = FirebaseAuth.instance;
    RegExp regex = RegExp(pattern);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: mheight * 0.0245,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Color(0xffA0A0A0),
              size: 16,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/signup.png',
              height: mheight * 0.25,
              width: mwidth * 0.5,
            ),
          ),
          SizedBox(
            height: mheight * 0.045,
          ),
          Center(
            child: Text(
              'Create Your Account',
              style: TextStyle(
                  color: Color(0xff0E697C),
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'title'),
            ),
          ),
          Form(
            key: form_key,
            child: Column(
              children: [
                SizedBox(height: mheight * 0.04),
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
                            padding: EdgeInsets.only(left: mwidth * 0.04),
                            child: SizedBox(
                              width: mwidth * 0.075,
                              height: mheight * 0.03,
                              child: Image.asset(
                                'assets/username.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: mwidth * 0.04),
                              width: mwidth * 0.756,
                              height: mheight * 0.08,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: userName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field should not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  username1 = value!;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: Color(0xff7DAEB8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'title')),
                              )),
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
                              height: mheight * 0.03,
                              width: mwidth * 0.075,
                              child: Image.asset(
                                'assets/email.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: mwidth * 0.04, top: mheight * 0.0038),
                              width: mwidth * 0.756,
                              height: mheight * 0.08,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: signupPageEmail,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !regex.hasMatch(value)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  signuppage_email1 = value!;
                                  signuppage_email1 = value!.trim();
                                  value.replaceAll(RegExp(r'\s+'), '');
                                },onChanged: (value) {

                                signupPageEmail.value = TextEditingValue(
                                  text: value.trim(),
                                  selection:  signupPageEmail.selection,
                                );
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
                              )),
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
                            padding: EdgeInsets.only(left: mwidth * 0.04),
                            child: SizedBox(
                              width: mwidth * 0.075,
                              height: mheight * 0.03,
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
                                textInputAction: TextInputAction.done,
                                obscureText: passwordvisible ? false : true,
                                controller: signupPagePassword,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'Password should be atleast 6 character';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  signuppage_password1 = value!;
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
                                                size: 18,
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
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mheight * 0.04,
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
                              createAccount(userName.text, signupPageEmail.text, signupPagePassword.text);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff0E697C),
                                borderRadius: BorderRadius.circular(50)),
                            width: mwidth * 0.32,
                            height: mheight * 0.05,
                            child: const Center(
                              child: Text(
                                'SIGN UP',
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
                  height: mheight * 0.05,
                ),
                Row(children: [
                  SizedBox(
                    width: mwidth * 0.156,
                  ),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Color(0xff484848),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'title'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const Login_Page()));
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          color: Color(0xff0E697C),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'title'),
                    ),
                  ),
                ]),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
        ])));
  }

  @override
  void dispose() {
    signupPageEmail.clear();
    signupPagePassword.clear();
    userName.clear();
    super.dispose();
  }
}

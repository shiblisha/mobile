import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../toast_message.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  String email1='';
  final form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    FirebaseAuth auth = FirebaseAuth.instance;

    RegExp regex = RegExp(pattern);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      body: Form(
        key: form_key,
        child: Column(
          children: [
            SizedBox(
              height: mheight * 0.42,
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
                          controller: email,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email1 = value!;
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
              height: mheight * 0.012,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  final isvalid = form_key.currentState?.validate();
                  if (isvalid == true) {
                    form_key.currentState?.save();
                    auth
                        .sendPasswordResetEmail(email: email.text)
                        .then((value){ ToastMessage().toastmessage(
                            message: 'Password Reset Email Has Beeen Sent');
                        Navigator.of(context).pop();})
                        .onError((error, stackTrace) => ToastMessage()
                            .toastmessage(message: error.toString()));
                  }
                },
                child:Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff0E697C),
                      borderRadius: BorderRadius.circular(50)
                  ),
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
          ],
        ),
      ),
    );
  }
}

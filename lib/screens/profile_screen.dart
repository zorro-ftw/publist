import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:publist/components/rounded_button.dart';
import 'package:publist/screens/forgot_password_screen.dart';
import 'package:publist/screens/registration_screen.dart';
import 'package:publist/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:auth_buttons/auth_buttons.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  static const IconData pen = IconData(0xf2bf);
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final user= _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainThemeColor,
        title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 25),
            SizedBox(height: 115,width: 115,child: CircleAvatar(backgroundColor: Colors.black,),),
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: user.displayName),
                  ),
                ),

                Icon(Icons.border_color),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),

          ],
        ),
      ),
    );
  }
}

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

  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final user= _auth.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 150.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 36.0,
              ),
              Text (
                user.displayName,
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
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Sign In',
                color: Color(0xFFCE9F35),
                onPressed: () async {
                },
              ),
              SizedBox(
                height: 10,
              ),
              GoogleAuthButton(
                //title: 'Google',
                //color: Color(0xFFD08933),
                onPressed: () async {
                },
              ),
              SizedBox(
                height: 10,
              ),
              FacebookAuthButton(
                //title: 'Facebook',
                //color: Color(0xFFD08933),
                onPressed: () async {
                },
              ),
              SizedBox(
                height: 25,
              ),
              RoundedButton(
                title: "Don't have an account? Sign Up",
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
              SizedBox(
                height:0,
              ),
              RoundedButton(
                title: "Forgot Password?",
                color: Colors.grey,
                onPressed: () {
                  Navigator.pushNamed(context, ForgotPasswordScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

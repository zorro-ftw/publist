import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:publist/auth_service.dart';
import 'package:publist/components/rounded_button.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/screens/registration_screen.dart';
import 'package:publist/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:publist/screens/main_screen.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = AuthService();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
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
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
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
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (user != null) {
                      Navigator.pushNamed(context, MainScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              GoogleAuthButton(
                //title: 'Google',
                //color: Color(0xFFD08933),
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithGoogle();
                    if (user != null) {
                      Navigator.pushNamed(context, MainScreen.id);
                      print(user.user.displayName);
                      print(user.user.email);
                      print(user.user.uid);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    print(e.toString());
                    setState(() {
                      showSpinner = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              FacebookAuthButton(
                //title: 'Facebook',
                //color: Color(0xFFD08933),
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithFacebook();
                    if (user != null) {
                      Navigator.pushNamed(context, MainScreen.id);
                      print(user.user.displayName);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    print(e.toString());
                    setState(() {
                      showSpinner = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message),
                      ),
                    );
                  }
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
            ],
          ),
        ),
      ),
    );
  }
}

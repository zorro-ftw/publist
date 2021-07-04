import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';
import 'package:publist/screens/login_screen.dart';
import 'package:publist/screens/registration_screen.dart';
import 'package:publist/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:publist/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Publist());
}

class Publist extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        },
      ),
    );
  }
}

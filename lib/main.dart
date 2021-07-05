import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';
import 'package:publist/screens/group_related_screens/group_main_screen.dart';
import 'package:publist/screens/login_screen.dart';
import 'package:publist/screens/registration_screen.dart';
import 'package:publist/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:publist/screens/main_screen.dart';
import 'package:publist/models/user_group_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Publist());
}

class Publist extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserGroupData(),
        )
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          GroupMainScreen.id: (context) => GroupMainScreen(),
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        },
      ),
    );
  }
}

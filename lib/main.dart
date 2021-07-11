import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';
import 'package:publist/models/user_invite_data.dart';
import 'package:publist/screens/forgot_password_screen.dart';
import 'package:publist/screens/group_related_screens/group_main_screen.dart';
import 'package:publist/screens/login_screen.dart';
import 'package:publist/screens/registration_screen.dart';
import 'package:publist/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:publist/screens/main_screen.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/models/group_data.dart';

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
        ),
        ChangeNotifierProvider(
          create: (context) => GroupData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserInviteData(),
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
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
        },
      ),
    );
  }
}

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
import 'package:publist/screens/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:publist/models/group_task_data.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
          int id,
          String title,
          String body,
          String payload,
          ) async {});
  const MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
      });
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("America/Los_Angeles"));

  runApp(Publist());
}

class Publist extends StatelessWidget {
  String _inRoot;
  final user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      _inRoot = MainScreen.id;
    } else {
      _inRoot = LoginScreen.id;
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserGroupData(),
        ),
        ChangeNotifierProvider(
          create: (context) => GroupData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserInviteData(),
        ),
        ChangeNotifierProvider(
          create: (context) => GroupTaskData(),
        )
      ],
      child: MaterialApp(
        initialRoute: _inRoot,
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

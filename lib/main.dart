import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_sapient_assignment/onboarding.dart';
import 'package:todo_sapient_assignment/screens/home.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _currentUser = await _signInAnonymously();
  print('user:$_currentUser');
  runApp(MyApp());
}

final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseUser _currentUser;

Future<FirebaseUser> _signInAnonymously() async {
  final user = await _auth.signInAnonymously();
  return user;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    _initializeLocalNotificationsPlugin(context);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Agora',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: Colors.white),
          home: Onboarding(
            user: _currentUser,
          ),
        );
      });
    });
  }

  void _initializeLocalNotificationsPlugin(BuildContext context) {
    AndroidInitializationSettings settingsAndroid =
        AndroidInitializationSettings('logo');
    var settingsIOS = IOSInitializationSettings();
    notifications.initialize(
      InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
      onSelectNotification: (payload) {
        _onSelectNotification(context, payload);
      },
    );
  }

  Future _onSelectNotification(BuildContext context, String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/screen/home.dart';
import 'package:zoom_clone/screen/join_meeting/join_meeting.dart';
import 'package:zoom_clone/screen/login_screen.dart';
import 'package:zoom_clone/screen/signUp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/join-meeting': (context) => const JoinMeetingScreen(),
        '/register': (context) => const SignUpScreen(),
      },
      initialRoute: '/login',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:first_app/Screens/Welcome/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Cupboards',
      home: WelcomeScreen(),
    );
  }
}

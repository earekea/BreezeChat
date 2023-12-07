import 'package:flutter/material.dart';
import 'package:chat_breeze/screens/welcome_screen.dart';
import 'package:chat_breeze/screens/login_screen.dart';
import 'package:chat_breeze/screens/registration_screen.dart';
import 'package:chat_breeze/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatBreeze());
}

class ChatBreeze extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id:(context)=>WelcomeScreen(),
          LoginScreen.id:(context)=>LoginScreen(),
          RegistrationScreen.id:(context)=>RegistrationScreen(),
          ChatScreen.id:(context)=>ChatScreen(),

        }
    );
  }
}

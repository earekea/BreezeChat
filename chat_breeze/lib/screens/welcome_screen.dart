import 'package:chat_breeze/screens/login_screen.dart';
import 'package:chat_breeze/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_breeze/components/Rounded_Button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
late AnimationController controller;
late Animation animation;

@override
  void initState() {
    super.initState();
    controller= AnimationController(duration:Duration(seconds: 2) ,vsync: this);
    animation= ColorTween(begin: Color(0xFF83c5be),end: Color(0XFF006d77)).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    },);
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    padding: EdgeInsets.only(right: 10.0),
                  ),
                ),
                DefaultTextStyle(style: TextStyle(fontSize: 50.0,
                fontWeight:FontWeight.w900,
                  color: Color(0xFF22223b)
                ), child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Breeze Chat'),

                  ],
                )
                )
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            RoundedButton(title: 'Log İn', color: Color(0xfff4d35e),onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },),
          RoundedButton(title: 'Register', color: Color(0xfff4d35e), onPressed: (){
            Navigator.pushNamed(context, RegistrationScreen.id);
    }),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Column(
                children: [
                  Image.asset('images/chat.png',
                  width: 150,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:papas/pages/login_page.dart';
import 'package:papas/pages/sign_up_page.dart';

class LoginAndSignUp extends StatefulWidget {
  const LoginAndSignUp({super.key});

  @override
  State<LoginAndSignUp> createState() => _LoginAndSignUpState();
}

class _LoginAndSignUpState extends State<LoginAndSignUp> {
  bool islogin = true;

  void tooglePage() {
    setState(() {
      islogin = !islogin;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    if (islogin) {
      return LoginPage(
        onPressed: tooglePage,
      );
    } else {
      return SignUp(
        onPressed: tooglePage,
      );
    }
  }
}

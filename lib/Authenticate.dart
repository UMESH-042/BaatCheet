import 'package:chatapp/homescreen.dart';
import 'package:chatapp/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  
final  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return HomeScreen(currentUserEmail: '',);
    } else {
      return LoginScreen();
    }
  }
}

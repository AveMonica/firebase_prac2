import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:practice/home.dart';
import 'package:practice/register.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();

  var pass = TextEditingController();

  void login() async {
    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text, 
        password: pass.text,
      ).then((value) {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => HomeScreen())
        );
      }).catchError((error) {
        EasyLoading.showError('incorrect email or pass.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: email,

              ),
              TextField(
                controller: pass,
              ),
              ElevatedButton(
                onPressed: login, 
                child: Text('Login')
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (_) => RegisterScreen())
                  );
                }, 
                child: Text('Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
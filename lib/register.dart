import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  var email = TextEditingController();
  var pass = TextEditingController();

  void register() async {
    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, 
        password: pass.text
      ).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        EasyLoading.showError('Incorrect');
      });
    }
  }

  // register with other data
  // void register() {
  //   //validate
  //   if (!formKey.currentState!.validate()) {
  //     return;
  //   }
  //   //confirm to the user
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.confirm,
  //     title: 'Are you sure?',
  //     confirmBtnText: 'YES',
  //     cancelBtnText: 'No',
  //     onConfirmBtnTap: () {
  //       //register in firebase auth
  //       Navigator.of(context).pop();
  //       registerClient();
  //     },
  //   );
  // }

  // void registerClient() async {
  //   try {
  //     QuickAlert.show(
  //       context: context,
  //       type: QuickAlertType.loading,
  //       title: 'Loading',
  //       text: 'Registering your account',
  //     );
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text, 
  //       password: password.text
  //     );
  //     //firestore add document
  //     String user_id = userCredential.user!.uid;
  //     await FirebaseFirestore.instance.collection('users').doc(user_id).set({
  //       'firstname': firstName.text,
  //       'lastname': lastName.text,
  //       'email': email.text,
  //       'type': 'client'
  //     });
  //     Navigator.of(context).pop();
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (_) => LoginScreen(),),
  //     );
  //   } on FirebaseAuthException catch (ex) {
  //     Navigator.of(context).pop();
  //     var errorTitle = '';
  //     var errorText = '';
  //     if (ex.code == 'weak-password') {
  //       errorText = 'Please enter a password with more than 6 characters';
  //       errorTitle = 'Weak Password';
  //     } else if (ex.code == 'email-already-in-use') {
  //       errorText = 'Password is already registered';
  //       errorTitle = 'Please enter a new email.';
  //     }
  //     QuickAlert.show(
  //       context: context,
  //       type: QuickAlertType.error,
  //       title: errorTitle,
  //       text: errorText,
  //     );
  //   }
  // }

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
                onPressed: register, 
                child: Text('Register')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
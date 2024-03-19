import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  void deleteAcc() async {
  try {
    if (user != null) {
      await user!.delete();
      print('User account deleted successfully.');
    } else {
      print('No user signed in.');
    }
  } catch (e) {
    print('Failed to delete user account: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [
          IconButton(onPressed: deleteAcc, icon: Icon(Icons.delete)),
        ],
      ),
      // --- makukuha niya lahat ng data
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('sample').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          var users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var userData = users[index].data();
              return ListTile(
                title: Text(userData['name']),
                subtitle: Text(userData['address']),
              );
            }
          );
        },
      ),
      // --- makukuha niya yung data base kung sino nakalogin
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('sample').doc(user?.uid).snapshots(), 
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(child: CircularProgressIndicator(),);
      //     }
      //     var userData = snapshot.data!.data();
      //     if (userData == null) {
      //       return Center(child: Text('No data available'));
      //     }
      //     return ListTile(
      //       title: Text(userData!['name']),
      //       subtitle: Text(userData['address']),
      //     );
      //   }
      // ),
    );
  }
}
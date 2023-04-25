import 'package:expensetracker/InitialScreens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        setState(() {});
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignUppageWidget()));
      },
      child: Center(child: Text('Log Out')),
    );
  }
}

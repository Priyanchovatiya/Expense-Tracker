import 'package:expensetracker/InitialScreens/sign_up.dart';
import 'package:expensetracker/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../customs/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var email ;

  Future<void> getCurrentUser()  async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    setState(() {
      email = user!.email;
    });
    print(user!.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  greyBGColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(12.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomText(
                    text: "Profile",
                    fontWeight: FontWeight.w500,
                    size: 30.0,
                    colour: Color(0xFF111111),
                  ),

                  SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Image.asset(
                        'assests/img/avtar.png',
                        height: 150,
                      ))),
                  const SizedBox(
                    height: 15,
                  ),

                  Center(
                    child: CustomText(
                      text: email != null ? email.toString() : "Fetching Data..",
                      fontWeight: FontWeight.w700,
                      size: 20.0,
                      colour: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {

                          },
                          trailing: const Icon(CupertinoIcons.forward),
                          leading: const Icon(CupertinoIcons.line_horizontal_3),
                          title: const CustomText(
                            text: 'Transactions',
                            size: 15.0,
                            fontWeight: FontWeight.w500,
                            colour: Color(0xFF111111),
                          ),

                        ),
                        const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            height: 3.0,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          onTap: () {

                          },
                          trailing: const Icon(CupertinoIcons.forward),
                          leading: const Icon(CupertinoIcons.money_dollar,),
                          title: const CustomText(
                            text: 'Budget',
                            size: 15.0,
                            fontWeight: FontWeight.w500,
                            colour: Color(0xFF111111),
                          ),

                        ),
                        const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            height: 3.0,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            setState(() {});
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUppageWidget()));
                          },
                          trailing: const Icon(CupertinoIcons.forward),
                          leading: const Icon(FontAwesomeIcons.signOut,size: 20.0,),
                          title: const CustomText(
                            text: 'Sign Out',
                            size: 15.0,
                            fontWeight: FontWeight.w500,
                            colour: Color(0xFF111111),
                          ),

                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

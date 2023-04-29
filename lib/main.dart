import 'package:expensetracker/InitialScreens/home_screen.dart';
import 'package:expensetracker/InitialScreens/log_in.dart';
import 'package:expensetracker/controller/ads.dart';
import 'package:expensetracker/controller/sign_in_control.dart';
import 'package:expensetracker/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await Ads().loadopenad();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSingInProivder(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Something Went Wrong"),
                    );
                  } else if (snapshot.hasData) {
                    return Center(
                      child: HomeScreen(),
                    );
                  } else {
                    return LoginpageWidget();
                  }
                }),
          )),
    );
  }
}

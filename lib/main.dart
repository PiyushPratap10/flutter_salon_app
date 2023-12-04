// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/firebase_options.dart';
import 'package:salon_app/screens/categories.dart';
import 'package:salon_app/screens/main_screen.dart';
import 'package:salon_app/screens/otp.dart';
import 'package:salon_app/screens/phone.dart';
import 'package:salon_app/screens/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'phone': (context) => const NumberLogin(),
        'otp': (context) => const OtpScreen(),
        'tab': (context) => const TabsScreen(),
        'main': (context) => const MainScreen(),
        'category': (context) => const CategoriesScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return const TabsScreen();
            } else {
              return const NumberLogin();
            }
          }),
    );
  }
}

import 'package:best_plug_gadgets/auth/auth.dart';
import 'package:best_plug_gadgets/screens/home_screen.dart';
import 'package:best_plug_gadgets/screens/login_screen.dart';
import 'package:best_plug_gadgets/screens/test_screen.dart';
import 'package:best_plug_gadgets/services/store/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // remove status bar
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Auth.instance(FirebaseAuth.instance)),
        ChangeNotifierProvider.value(
            value: Firestrore.instance(FirebaseFirestore.instance)),
      ],
      child: MaterialApp(
        // title: 'BestPlugGadgets',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

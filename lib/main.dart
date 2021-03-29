import 'package:best_plug_gadgets/auth/auth.dart';
import 'package:best_plug_gadgets/screens/login_screen.dart';
import 'package:best_plug_gadgets/screens/signup_screen.dart';
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
        // Provider<Auth>(
        //   create: (_) => Auth(FirebaseAuth.instance),
        // )
        ChangeNotifierProvider.value(value: Auth(FirebaseAuth.instance)),
      ],
      child: MaterialApp(
        // title: 'BestPlugGadgets',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        home: LoginScreen(),
      ),
    );
  }
}

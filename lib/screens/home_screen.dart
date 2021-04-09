import 'package:best_plug_gadgets/auth/auth.dart';
import 'package:best_plug_gadgets/screens/login_screen.dart';
import 'package:best_plug_gadgets/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      // ignore: missing_return
      builder: (context, auth, _) {
        switch (auth.status){
          case Status.Unininitialized:
          case Status.Unauthenticated:
            return LoginScreen();
          case Status.Authenticating:
            return LoadingScreen();
          case Status.Authenticated:
            return FeedScreen();
          case Status.NewUser:
            return SignUpScreen();
        }
      },
    );
  }
}

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Here lies the FeedScreen'),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

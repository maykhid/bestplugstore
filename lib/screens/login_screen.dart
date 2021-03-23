import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:best_plug_gadgets/services/screen_data.dart';
import 'package:best_plug_gadgets/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Sign in to continue!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: ScreenData.screenHeight / 4,
            // ),
            Form(
              child: Container(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  children: [
                    TextInputField(
                      labelText: 'Full Name',
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextInputField(
                      labelText: 'Email ID',
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextInputField(
                      labelText: 'Password',
                    ),
                  ],
                ),
              ),
            ),
            Button.plain(context: context, label: "test sign in",
                // iconData: FontAwesomeIcons.facebookF,
                gradientColors: [AppColors.pink, Colors.white]),
          ],
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  final String labelText;
  TextInputField({@required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: const BorderSide(color: AppColors.pink, width: 0.0),
        ),
        enabledBorder: const OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}

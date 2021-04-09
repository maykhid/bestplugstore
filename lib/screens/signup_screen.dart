import 'package:best_plug_gadgets/auth/auth.dart';
import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:best_plug_gadgets/screens/login_screen.dart';
import 'package:best_plug_gadgets/services/screen_data.dart';
import 'package:best_plug_gadgets/services/validators.dart';
import 'package:best_plug_gadgets/widgets/buttons.dart';
import 'package:best_plug_gadgets/widgets/ui_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;
  FormType _formType = FormType.register;

  @override
  Widget build(BuildContext context) {
    ScreenData().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ScreenData.screenHeight / (ScreenData.half * 8),
                ),
                WelcomeUser(
                  boldText: 'Create Account',
                  boldSubText: 'Sign up to get started!',
                ),
                SizedBox(
                  height: ScreenData.screenHeight / (ScreenData.half * 4),
                ),
                _buildSignUpForm(),
                SizedBox(
                  height: ScreenData.screenHeight / 12,
                ),
                Button.plain(
                  context: context,
                  label: "Sign Up",
                  gradientColors: [AppColors.pink, AppColors.lightOrange],
                  useIcon: false,
                  onPressed: () {
                    print("Test onPress");
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      Provider.of<Auth>(context, listen: false)
                          .validateAndSubmit(
                              formKey, _formType, _email, _password);
                    }
                  },
                ),
                SizedBox(
                  height: ScreenData.screenHeight / (ScreenData.five * 9),
                ),
                Button.plain(
                  context: context,
                  label: "Connect with Google",
                  useGradient: false,
                  buttonColor: AppColors.greyWhite,
                  labelColor: AppColors.pink,
                  useIcon: true,
                ),
                SizedBox(
                  height: ScreenData.screenHeight / ScreenData.ten,
                ),
                _buildBottomText(),
                // SizedBox.expand()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomText() {
    return Center(
      child: BottomText(
        firstText: 'Already a member',
        secondText: 'Log in',
        onPressed: _goto,
      ),
    );
  }

  _buildSignUpForm() {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          children: [
            TextInputField(
              labelText: 'Full Name',
            ),
            TextInputField(
              labelText: 'Email ID',
              validator: EmailFieldValidator.validate,
              onSaved: (String value) => _email = value,
            ),
            TextInputField(
              labelText: 'Password',
              shouldObscureText: true,
              validator: PasswordFieldValidator.validate,
              onSaved: (String value) => _password = value,
            ),
          ],
        ),
      ),
    );
  }

  void _goto() {
    // This updates Status to Unauthenticated so it can move to the LoginScreen
    Provider.of<Auth>(context, listen: false)
                .updateStatus(Status.Unauthenticated);
  }
}

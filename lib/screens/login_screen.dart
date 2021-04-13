import 'package:best_plug_gadgets/auth/auth.dart';
import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:best_plug_gadgets/screens/signup_screen.dart';
import 'package:best_plug_gadgets/services/screen_data.dart';
import 'package:best_plug_gadgets/services/validators.dart';
import 'package:best_plug_gadgets/widgets/buttons.dart';
import 'package:best_plug_gadgets/widgets/ui_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    ScreenData().init(context);

    return Consumer<Auth>(builder: (context, auth, _) {
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
                    boldText: 'Welcome',
                    boldSubText: 'Sign in to continue!',
                  ),

                  SizedBox(
                    height: ScreenData.screenHeight / (ScreenData.half * 4),
                  ),

                  _buildLoginForm(),

                  SizedBox(
                    height: ScreenData.screenHeight / 12,
                  ),

                  Button.plain(
                    context: context,
                    label: "Login",
                    gradientColors: [AppColors.pink, AppColors.lightOrange],
                    useIcon: false,
                    onPressed: () {
                      print("Test onPress");
                      //TODO: Modularize the code below
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        // context
                        //     .read<Auth>()
                        //     .validateAndSubmit(formKey, _email, _password);
                        auth.validateAndSubmit(formKey, _email, _password);
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
                    onPressed: () =>
                        // Provider.of<Auth>(context, listen: false)
                        //     .signInWithGoogle();
                        auth.signInWithGoogle(),
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
    });
  }

  _buildBottomText() {
    return Center(
      child: BottomText(
        firstText: 'New User',
        secondText: 'Sign up',
        // onPressed: () {
        //   Provider.of<Auth>(context, listen: false)
        //       .updateStatus(Status.NewUser);
        // }
        onPressed: _goto,
      ),
    );
  }

  _buildLoginForm() {
    return Form(
      key: formKey,
      child: Container(
        // padding: EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            TextInputField(
              labelText: 'Email ID',
              validator: EmailFieldValidator.validate,
              onSaved: (String value) => _email = value,
            ),
            // SizedBox(
            //   height: 12.0,
            // ),
            TextInputField(
              labelText: 'Password',
              shouldObscureText: true,
              validator: PasswordFieldValidator.validate,
              onSaved: (String value) => _password = value,
            ),
            // SizedBox(
            //   height: 12.0,
            // ),
            Align(
              child: Text(
                'Forgot password?',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }

  void _goto() {
    // This updates Status to NewUser so it can move to the SignUpScreen
    Provider.of<Auth>(context, listen: false).updateStatus(Status.NewUser);
  }
}

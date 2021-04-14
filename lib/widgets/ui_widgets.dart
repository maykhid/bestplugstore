import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WelcomeUser extends StatelessWidget {
  final String boldText;
  final String boldSubText;
  WelcomeUser({@required this.boldText, @required this.boldSubText});
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$boldText,',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 40.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            boldSubText,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'OpenSans',
                color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  final String labelText;
  final FormFieldValidator<String> validator;
  final bool shouldObscureText;
  final FormFieldSetter<String> onSaved;
  TextInputField(
      {@required this.labelText,
      this.validator,
      this.shouldObscureText = false,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        decoration: _getTextFieldDeco(labelText),
        validator: validator,
        obscureText: shouldObscureText,
        onSaved: onSaved,
      ),
    );
  }
}

InputDecoration _getTextFieldDeco(String labelText) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      // remember width: 0.0 produces a thin "hairline" border
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: AppColors.pink, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      // remember width: 0.0 produces a thin "hairline" border
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
    ),
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.grey),
  );
}

class BottomText extends StatefulWidget {
  final String firstText, secondText;
  final Function onPressed;
  BottomText(
      {@required this.firstText, @required this.secondText, this.onPressed});
  @override
  _BottomTextState createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  TapGestureRecognizer _tapRecognizer;
  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = widget.onPressed;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
            text: '${widget.firstText}?  ',
            style: TextStyle(color: Colors.black38),
            children: [
              TextSpan(
                  text: '${widget.secondText} ->',
                  style: TextStyle(color: AppColors.pink),
                  recognizer: _tapRecognizer),
            ]),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.0,
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'First screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                'First screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                'First screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                'First screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InAppGreet extends StatelessWidget {
  final Color topTextColor, bottomTextColor;
  InAppGreet({this.topTextColor, this.bottomTextColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
            text: 'Good Morning \n',
            style: TextStyle(
              color: topTextColor,
              fontSize: 8.0.sp,
              fontFamily: 'OpenSans',
              // fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'Henry',
                style: TextStyle(
                  color: bottomTextColor,
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ]),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 7.0.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.greyWhite,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.0.w,
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                // focusedBorder: InputBorder.none,
                // enabledBorder: InputBorder.none,
                // errorBorder: InputBorder.none,
                // disabledBorder: InputBorder.none,
                hintText: "Search for products",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

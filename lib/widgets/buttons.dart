// import 'package:flutter/cupertino.dart';
import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:best_plug_gadgets/services/screen_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Button {
  static Widget signInOption(
      {@required BuildContext context,
      double borderRadius = 10,
      Color buttonColor = Colors.green,
      @required String label,
      double labelSize = 30,
      Color labelColor,
      @required IconData iconData,
      double iconSize = 24,
      Function onPressed}) {
    ScreenData().init(context);
    return TextButton(
      onPressed: onPressed,
      // color: buttonColor,
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),

      // child: Container(
      //   decoration: BoxDecoration(
      //     // gradient: LinearGradient(colors: gradientColors),
      //     color: buttonColor,
      //     borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      //   ),
      //   // margin: EdgeInsets.only(right: ScreenData.blockSizeHorizontal * 5.56),
      //   padding: EdgeInsets.symmetric(
      //       vertical: ScreenData.blockSizeHorizontal * 4.9),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Container(
      //         //margin: EdgeInsets.only(right: ScreenData.blockSizeHorizontal * 4.167),
      //         child: Icon(
      //           iconData,
      //           color: labelColor,
      //           size: iconSize,
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.only(left: 15),
      //         child: Text(
      //           label,
      //           textAlign: TextAlign.center,
      //           style: Theme.of(context).textTheme.bodyText2.copyWith(
      //               color: labelColor,
      //               fontSize: labelSize,
      //               letterSpacing: 0.2,
      //               fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  static Widget plain(
      {BuildContext context,
      Color buttonColor,
      double borderRadius = 10,
      double horizontalPadding = 2,
      double verticalPadding = 8,
      @required String label,
      double labelPadding = 10,
      double labelSize = 22,
      Color labelColor = Colors.white,
      List<Color> gradientColors,
      bool useGradient = true,
      bool useIcon = true,
      Function onPressed}) {
    // init ScreenData
    ScreenData().init(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: _buttonContainer(
          useGradient, gradientColors, buttonColor, useIcon, label, labelColor),
      onTap: onPressed,
    );
  }

  // this basically serves as the button's main structure
  static Container _buttonContainer(
      bool useGradient,
      List<Color> gradientColors,
      Color buttonColor,
      bool useIcon,
      String label,
      Color labelColor) {
    return Container(
      height: 50.0,
      // padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Ink(
        decoration: _buttonDecoration(useGradient, gradientColors, buttonColor),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: ScreenData.screenWidth, minHeight: 50.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _visibility(useIcon),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // for visibility
  static Visibility _visibility(bool useIcon) {
    // decides if icon is to be shown or not, using the bool useIcon property
    return Visibility(
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.google,
            color: AppColors.pink,
          ),
          SizedBox(
            width: ScreenData.screenWidth / (ScreenData.ten * 4),
          ),
        ],
      ),
      visible: useIcon,
    );
  }

  // for button decoration
  static BoxDecoration _buttonDecoration(
      bool useGradient, List<Color> gradientColors, Color buttonColor) {
    // logic to decide if gradient is used or not
    if (useGradient)
      return BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      );
    else
      return BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10.0),
      );
  }
}

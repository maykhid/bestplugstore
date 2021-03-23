// import 'package:flutter/cupertino.dart';
import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:best_plug_gadgets/services/screen_data.dart';
import 'package:flutter/material.dart';

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
      String label,
      double labelPadding = 10,
      double labelSize = 22,
      Color labelColor,
      List<Color> gradientColors,
      Function onPressed}) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      // margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(0.0),
        ),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.pink, AppColors.lightOrange],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: ScreenData.screenWidth / 1.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Gradient Button",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

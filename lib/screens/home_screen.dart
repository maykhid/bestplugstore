import 'dart:ui';

import 'package:best_plug_gadgets/extras/app_colors.dart';
import 'package:best_plug_gadgets/widgets/ui_widgets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      // drawer: AppDrawer(),
      backgroundColor: AppColors.greyerWhite.withOpacity(1.0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 1.0.h),
          child: Column(
            children: [
              // greeting and menubar
              _buildGreetandMenu(context),

              SizedBox(height: 4.0.h),

              // searchbar
              SearchWidget(),

              SizedBox(height: 3.0.h),

              // daily deals
              _buildDailyDeals(),

              //populaar categories
              _buildPopularCategories(),
            ],
          ),
        ),
      ),
    );
  }

  _buildDailyDeals() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 1.0.h,
            right: 1.0.h,
            bottom: 1.5.h,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Daily Deals',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        // ListView Builder
        Container(
          height: 38.0.h,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return DailyDealsCard();
            },
          ),
        ),
      ],
    );
  }

  _buildPopularCategories() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 1.5.h,
            left: 1.0.h,
            right: 1.0.h,
            bottom: 2.5.h,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Popular Categories',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          height: 15.0.h,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return // popular categories card
                  PopularCategoriesCard();
            },
          ),
        ),
      ],
    );
  }

  _buildGreetandMenu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 1.0.h,
        right: 1.0.h,
      ),
      child: Container(
        child: Row(
          children: [
            // emoji
            Text(
              '👋 ',
              style: TextStyle(fontSize: 20.0.sp),
            ),
            // greeting and name
            InAppGreet(
              topTextColor: Colors.black38,
              bottomTextColor: Colors.black,
            ),
            // expands the space between greeting and menubar
            Expanded(child: SizedBox()),
            // menubar
            IconButton(
              icon: Icon(Icons.menu_sharp),
              onPressed: () {
                RootScaffold.openDrawer(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// This [RootScaffold] has access to the topmost scaffold on main()
/// and is able to keep its state across the app, so from anywhere on the app one can
/// access the scaffold by doing [RootScaffold.openDrawer(context)] (as long as the page or screen is under the tree).
class RootScaffold {
  static openDrawer(BuildContext context) {
    final ScaffoldState scaffoldState =
        context.findRootAncestorStateOfType<ScaffoldState>();
    scaffoldState.openDrawer();
  }
}

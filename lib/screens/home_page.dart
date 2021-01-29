// import 'package:e_commerce_app/constants.dart';

import 'package:e_commerce_app/tabs/home_tab.dart';
import 'package:e_commerce_app/tabs/saved_tab.dart';
import 'package:e_commerce_app/tabs/search_tab.dart';
import 'package:e_commerce_app/widgets/bottom_navigation_buttons.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabController;
  int selectedTab;
  @override
  void initState() {
    _tabController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                  controller: _tabController,
                  onPageChanged: (number) {
                    setState(() {
                      selectedTab = number + 1;
                    });
                  },
                  children: [
                    HomeTab(),
                    SearchTab(),
                    SavedTab(),
                  ]),
            ),
            BottomTabs(
              selectedTab: selectedTab,
              tabPressed: (num) {
                setState(() {
                  _tabController.animateToPage(num,
                      duration: Duration(milliseconds: 900),
                      curve: Curves.easeIn);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

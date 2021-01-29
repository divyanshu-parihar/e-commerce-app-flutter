import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomTabs extends StatefulWidget {
  int selectedTab;
  final Function tabPressed;
  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 1;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1.0,
              blurRadius: 16.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottonTabButton(
            icon: Icons.home_outlined,
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottonTabButton(
            icon: Icons.search,
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottonTabButton(
            icon: Icons.bookmark_outline,
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottonTabButton(
            icon: Icons.exit_to_app,
            selected: _selectedTab == 4 ? true : false,
            onPressed: () {
              widget.tabPressed(3);
            },
          ),
        ],
      ),
    );
  }
}

class BottonTabButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function onPressed;
  BottonTabButton({this.icon, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool isSelected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
              color: isSelected
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
              width: 3.0,
            )),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          width: 46.0,
          height: 46.0,
          child: Icon(
            icon,
            color: isSelected ? Theme.of(context).accentColor : Colors.black,
          ),
        ),
      ),
    );
  }
}

import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomAppBar(
      {this.text, this.hasBackArrow, this.hasTitle, this.hasBackground});
  @override
  Widget build(BuildContext context) {
    bool _hasTitle = hasTitle ?? false;
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasBackground = hasBackground ?? true;
    return Container(
      padding: EdgeInsets.only(
        top: 56,
        bottom: 24,
        right: 24,
        left: 24,
      ),
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white10,
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          if (_hasTitle)
            Text(
              text ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

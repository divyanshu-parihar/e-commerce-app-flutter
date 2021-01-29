import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final Function(String) onChange;
  final Function(String) onSubmit;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  CustomInput({
    this.text,
    this.onChange,
    this.onSubmit,
    this.focusNode,
    this.textInputAction,
    this.isPassword,
  });

  Widget build(BuildContext context) {
    bool _isPassword = isPassword ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 17.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        obscureText: _isPassword,
        focusNode: focusNode,
        onChanged: onChange,
        onSubmitted: onSubmit,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          ),
          hintText: text,
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}

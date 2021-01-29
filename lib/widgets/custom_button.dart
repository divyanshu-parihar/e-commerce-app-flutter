import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineButton;
  final bool isloading;

  CustomButton({this.onPressed, this.outlineButton, this.text, this.isloading});
  @override
  Widget build(BuildContext context) {
    bool _isloading = isloading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: outlineButton ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Stack(
            children: [
              Center(
                child: Visibility(
                  visible: _isloading ? false : true,
                  child: Text(
                    text ?? 'Text',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: outlineButton ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _isloading,
                child: Center(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

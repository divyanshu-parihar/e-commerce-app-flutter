import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail,
        password: _registerPassword,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        return 'weak password';
      } else if (error.code == 'email-already-in-use') {
        return 'already in use';
      }
      return error.message;
    } catch (e) {
      return e.toString();
    }
  }

  void submitForm() async {
    setState(() {
      _registerFormloading = true;
    });
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _registerFormloading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // variables
  bool _registerFormloading = false;
  String _registerEmail = '';
  String _registerPassword = '';

  // focus Node
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // built-in alert dialog box
  Future<void> _alertDialogBuilder(String text) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Container(
            child: Text(
              text,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close Dialog',
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24,
                ),
                child: Text(
                  'Welcome User \n Create your Account',
                  style: Constants.boldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              // form
              Column(
                children: [
                  CustomInput(
                    text: 'Email',
                    onChange: (value) {
                      _registerEmail = value;
                    },
                    onSubmit: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    text: 'Password',
                    isPassword: true,
                    onChange: (value) {
                      _registerPassword = value;
                    },
                    onSubmit: (value) {
                      submitForm();
                    },
                    focusNode: _passwordFocusNode,
                  ),
                  CustomButton(
                    text: "Create",
                    onPressed: () {
                      submitForm();
                    },
                    outlineButton: false,
                    isloading: _registerFormloading,
                  ),
                ],
              ),
              // custon button
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomButton(
                  text: 'Back to Login',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineButton: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

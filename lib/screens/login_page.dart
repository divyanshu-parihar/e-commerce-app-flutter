import 'package:e_commerce_app/screens/home_page.dart';
import 'package:e_commerce_app/screens/register_page.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _loginEmail = '';
  String _loginPassword = '';
  bool _loginFormloading = false;

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail,
        password: _loginPassword,
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

  FocusNode _passwordLoginFocusNode;

  void submitForm() async {
    setState(() {
      _loginFormloading = true;
    });
    String _createAccountFeedback = await _loginAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _loginFormloading = false;
      });
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void initState() {
    _passwordLoginFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordLoginFocusNode.dispose();
    super.dispose();
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
                  'Welcome User \n Login to your Account',
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
                      _loginEmail = value;
                    },
                    onSubmit: (value) {
                      _passwordLoginFocusNode.requestFocus();
                    },
                  ),
                  CustomInput(
                    text: 'Password',
                    isPassword: true,
                    onChange: (value) {
                      _loginPassword = value;
                    },
                  ),
                  CustomButton(
                    text: 'LogIn',
                    onPressed: () {
                      submitForm();
                    },
                    outlineButton: false,
                    isloading: _loginFormloading,
                  ),
                ],
              ),
              // custon button
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomButton(
                  text: 'Create New Account',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
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

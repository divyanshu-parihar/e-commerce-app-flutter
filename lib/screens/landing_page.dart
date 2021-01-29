import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'home_page.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error : ${snapshot.error}'),
                    ),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User _user = streamSnapshot.data;
                  if (_user == null) {
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text(
                      'Checking Authentication',
                      style: Constants.regularHeading,
                    ),
                  ),
                );
              },
            );
          }
          // loading
          return Scaffold(
            body: Center(
              child: Text(
                'Initialized Authentication',
                style: Constants.regularHeading,
              ),
            ),
          );
        });
  }
}

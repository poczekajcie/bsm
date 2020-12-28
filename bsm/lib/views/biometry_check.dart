import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometryCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BiometryCheckState();
  }
}

class _BiometryCheckState extends State<BiometryCheckPage> {
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Zeskanuj odcisk palca',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skan odcisku palca'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _authorized == 'Authorized' ? RaisedButton(
              child: Text('Przejdź do notatek'),
              onPressed: () => Navigator.of(context).pushReplacementNamed('/notes'),
            ) : RaisedButton(
              child: Text(_isAuthenticating ? 'Anuluj' : 'Autoryzacja'),
              onPressed:
              _isAuthenticating ? _cancelAuthentication : _authenticate,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:bsm/button.dart';
import 'package:bsm/main.dart';
import 'package:crypto/crypto.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PasswordCheckSate();
  }
}

class _PasswordCheckSate extends State<PasswordCheckPage> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wpisz hasło'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Haslo'),
            ),
            Container(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('Przejdź do notatek', Colors.blue, () async {
                  final password = _passwordController.text;

                  var storageSalt = await storage.read(key: 'salt');

                  var saltedPassword = storageSalt + password;
                  var bytes = utf8.encode(saltedPassword);
                  var hash = sha256.convert(bytes).toString();

                  var storageHash = await storage.read(key: 'hash');

                  if (storageHash == hash) {
                    Navigator.of(context).pushReplacementNamed('/notes');
                  } else {
                    Flushbar(
                      title: 'Błąd',
                      message: 'Podano nieprawidłowe hasło',
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      flushbarStyle: FlushbarStyle.FLOATING,
                    )..show(context);
                  }
                }),
                Container(
                  height: 16.0,
                ),
                Button('Anuluj', Colors.grey, () {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

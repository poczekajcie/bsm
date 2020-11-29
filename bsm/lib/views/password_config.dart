import 'dart:convert';
import 'package:bsm/crypto/crypto.dart';
import 'package:bsm/main.dart';
import 'package:bsm/utils/button.dart';
import 'package:crypto/crypto.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_hash/salt.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class PasswordConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PasswordConfigSate();
  }
}

class _PasswordConfigSate extends State<PasswordConfigPage> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ustaw hasło'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Haslo'),
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
            ),
            Container(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('Ustaw', Colors.blue, () async {
                  final password = _passwordController.text;
                  String salt = Salt.generateAsBase64String(32);
                  String saltedPassword = salt + password;
                  var bytes = utf8.encode(saltedPassword);
                  String hash = sha256.convert(bytes).toString();

                  await storage.write(key: 'salt', value: salt);
                  await storage.write(key: 'hash', value: hash);

                  String dbFilePath = join(await getDatabasesPath(), 'safeNotesBsm.db');
                  print(dbFilePath);
                  if (!await io.File(dbFilePath).exists()) {
                    await openDatabase(
                      dbFilePath,
                      version: 1,
                      onCreate: (Database db, int version) async {
                        db.execute('''
                          create table Notes(
                            id integer primary key autoincrement,
                            title text not null,
                            text text not null
                          );
                        ''');
                      },
                    );
                  }

                  await EncryptData.encryptFile(dbFilePath);
                  await io.File(dbFilePath).delete();

                  Flushbar(
                    title: 'Sukces',
                    message: 'Zapisano hasło',
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                    flushbarStyle: FlushbarStyle.FLOATING,
                  )..show(context).then((value) =>
                      {Navigator.of(context).pushReplacementNamed('/')});
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

import 'package:bsm/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bsm/crypto/crypto.dart';
import 'package:crypto/crypto.dart';
import 'package:password_hash/salt.dart';
import 'package:path/path.dart';
import 'dart:math';

import 'package:sqflite/sqflite.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  bool isPasswordSet = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _checkIsPasswordSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bezpieczny notatnik'),
      ),
      body: Column(
        children: [
          !isPasswordSet ? Text('Ładowanie...'): Container(),
          isPasswordSet ? GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/biometry-check');
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 30, left: 13.0, right: 22.0),
                child: Text(
                  'Notatki',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ): Container(),
        ],
      ),
    );
  }

  void _checkIsPasswordSet() async {
    String hash = await storage.read(key: 'hash');
    if (hash == null) {
      await _setRandomPassword();
    }
    String storageHash = await storage.read(key: 'hash');
    setState(() {
      this.isPasswordSet = storageHash != null;
    });
  }

  Future<void> _setRandomPassword() async {
    String salt = Salt.generateAsBase64String(32);
    String saltedPassword = salt + getRandString(16);
    var bytes = utf8.encode(saltedPassword);
    String hash = sha256.convert(bytes).toString();

    await storage.write(key: 'salt', value: salt);
    await storage.write(key: 'hash', value: hash);

    String dbFilePath = join(await getDatabasesPath(), 'dbBsm3.db');
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

    await EncryptData.encryptFile(dbFilePath);
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }
}

import 'package:bsm/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          !isPasswordSet ? GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/password-config');
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 30, left: 13.0, right: 22.0),
                child: Text(
                  'Ustaw hasło',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ): Container(),
          isPasswordSet ? GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/password-check');
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
    setState(() {
      this.isPasswordSet = hash != null;
    });
  }
}

import 'package:bsm/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            ),
            Container(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('Ustaw', Colors.blue, () {
                  final password = _passwordController.text;
                  //TODO: set password here

                  Navigator.of(context).pushReplacementNamed('/');
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

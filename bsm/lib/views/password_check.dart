import 'package:bsm/button.dart';
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
                Button('Przejdź do notatek', Colors.blue, () {
                  final password = _passwordController.text;
                  //TODO: check password here

                  Navigator.of(context).pushReplacementNamed('/notes');
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

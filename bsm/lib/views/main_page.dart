import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bezpieczny notatnik'),
      ),
      body: Column(
        children: [
          GestureDetector(
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
          ),
          GestureDetector(
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
          ),
        ],
      ),
    );
  }
}

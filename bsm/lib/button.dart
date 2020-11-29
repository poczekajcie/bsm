import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String _text;
  final Color _color;
  final Function _onPressed;

  Button(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      height: 40,
      minWidth: 100,
      color: _color,
    );
  }
}
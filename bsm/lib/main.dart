import 'package:bsm/views/main_page.dart';
import 'package:bsm/views/note.dart';
import 'package:bsm/views/note_list.dart';
import 'package:bsm/views/password_check.dart';
import 'package:bsm/views/password_config.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notatki',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (_) => MainPage(),
        '/notes': (_) => NoteList(),
        '/note': (context) => Note(),
        '/password-config': (_) => PasswordConfigPage(),
        '/password-check': (_) => PasswordCheckPage(),
      },
    );
  }
}

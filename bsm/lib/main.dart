import 'package:bsm/views/note.dart';
import 'package:bsm/views/note_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Notes',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
//        '/': (_) => MainPage(),
        '/': (_) => NoteList(),
        '/note': (context) => Note(),
//        '/password-config': (_) => PasswordConfigPage(),
//        '/password-check': (_) => PasswordCheckPage(),
      },
      );
  }
}

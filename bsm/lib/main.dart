import 'package:bsm/views/biometry_check.dart';
import 'package:bsm/views/main_page.dart';
import 'package:bsm/views/note.dart';
import 'package:bsm/views/note_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(App());

final storage = FlutterSecureStorage();

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
        '/biometry-check': (_) => BiometryCheckPage(),
      },
    );
  }
}

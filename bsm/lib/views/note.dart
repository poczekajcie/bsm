import 'package:bsm/providers/note_provider.dart';
import 'package:bsm/utils/button.dart';
import 'package:bsm/utils/note_arguments.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum NoteMode {
  Editing,
  Adding
}

class Note extends StatefulWidget {

  @override
  NoteState createState() {
    return new NoteState();
  }
}

class NoteState extends State<Note> with WidgetsBindingObserver {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        Navigator.of(context).pushReplacementNamed('/password-check');
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final NoteRouteArguments args =  ModalRoute.of(context).settings.arguments;
    final NoteMode noteMode = args.mode;
    final Map<String, dynamic> note = args.note;

    if (noteMode == NoteMode.Editing) {
      _titleController.text = note['title'];
      _textController.text = note['text'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          noteMode == NoteMode.Adding ? 'Nowa notatka' : 'Edycja notatki'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Tytuł'
              ),
            ),
            Container(height: 8,),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Tekst notatki'
              ),
            ),
            Container(height: 16.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Button('Zapisz', Colors.blue, () {
                  final title = _titleController.text;
                  final text = _textController.text;

                  if (title.length == 0 || text.length == 0) {
                    Flushbar(
                      title: 'Błąd',
                      message: 'Nie można dodawać pustych notatek',
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                      flushbarStyle: FlushbarStyle.FLOATING,
                    )..show(context);
                  } else {
                    if (noteMode == NoteMode.Adding) {
                      NoteProvider.insertNote({
                        'title': title,
                        'text': text
                      });
                    } else if (noteMode == NoteMode.Editing) {
                      NoteProvider.updateNote({
                        'id': note['id'],
                        'title': _titleController.text,
                        'text': _textController.text,
                      });
                    }
                    Navigator.of(context).pushReplacementNamed('/notes');
                  }
                }),
                Container(height: 16.0,),
                Button('Anuluj', Colors.grey, () {
                  Navigator.of(context).pushReplacementNamed('/notes');
                }),
                noteMode == NoteMode.Editing ?
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Button('Usuń', Colors.red, () async {
                      await NoteProvider.deleteNote(note['id']);
                      Navigator.of(context).pushReplacementNamed('/notes');
                    }),
                  )
                 : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}




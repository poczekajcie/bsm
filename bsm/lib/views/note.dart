import 'package:bsm/note_arguments.dart';
import 'package:bsm/providers/note_provider.dart';
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

class NoteState extends State<Note> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

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
          noteMode == NoteMode.Adding ? 'Add note' : 'Edit note'
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
                hintText: 'Note title'
              ),
            ),
            Container(height: 8,),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Note text'
              ),
            ),
            Container(height: 16.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _NoteButton('Save', Colors.blue, () {
                  final title = _titleController.text;
                  final text = _textController.text;

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
                  Navigator.of(context).pushReplacementNamed('/');
                }),
                Container(height: 16.0,),
                _NoteButton('Discard', Colors.grey, () {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
                noteMode == NoteMode.Editing ?
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _NoteButton('Delete', Colors.red, () async {
                      await NoteProvider.deleteNote(note['id']);
                      Navigator.of(context).pushReplacementNamed('/');
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

class _NoteButton extends StatelessWidget {

  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text, this._color, this._onPressed);

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


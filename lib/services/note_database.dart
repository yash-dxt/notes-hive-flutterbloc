import 'package:hive/hive.dart';

import 'dart:async';

import '../models/note_model.dart';

class NoteDatabase {
  String _boxName = "Note";
  Future<Box> noteBox() async {
    var box = await Hive.openBox<Note>(_boxName);
    return box;
  }

  Future<List<Note>> getFullNote() async {
    final box = await noteBox();
    List<Note> notes = box.values.toList();
    return notes;
  }

  Future<int> addToBox(Note note) async {
    final box = await noteBox();

    var a = await box.add(note);
    return a;
  }

  Future<void> deleteFromBox(int index) async {
    final box = await noteBox();
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await noteBox();
    await box.clear();
  }

  Future<void> updateNote(int index, Note note) async {
    final box = await noteBox();
    await box.putAt(index, note);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/database_helper.dart';
import '../data/note_model.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DatabaseHelper dbHelper;

  NoteBloc(this.dbHelper) : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      final notes = await dbHelper.getNotes();
      emit(NoteLoaded(notes));
    });

    on<AddNote>((event, emit) async {
      await dbHelper.insertNote(event.note);
      add(LoadNotes());
    });

    on<UpdateNote>((event, emit) async {
      await dbHelper.updateNote(event.note);
      add(LoadNotes());
    });

    on<DeleteNote>((event, emit) async {
      await dbHelper.deleteNote(event.id);
      add(LoadNotes());
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../data/note_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final note = Note(
                  id: widget.note?.id,
                  title: titleController.text,
                  description: descController.text,
                );
                if (isEditing) {
                  context.read<NoteBloc>().add(UpdateNote(note));
                } else {
                  context.read<NoteBloc>().add(AddNote(note));
                }
                Navigator.pop(context);
              },
              child: Text(isEditing ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}

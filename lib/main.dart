import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/note_bloc.dart';
import 'bloc/note_event.dart';
import 'data/database_helper.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc(DatabaseHelper())..add(LoadNotes()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLoC CRUD',
        home: const HomeScreen(),
      ),
    );
  }
}

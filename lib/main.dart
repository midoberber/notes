import 'package:flutter/material.dart';
import 'package:note_app_task/model/home_notes_model.dart';
import 'package:note_app_task/model/user_model.dart';
import 'package:note_app_task/pages/home_note.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeNote(),
      ),
    );
  }
}

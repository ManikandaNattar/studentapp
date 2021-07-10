import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:student_app/student.dart';
import 'package:student_app/widgets/student/student_add_screen_with_retrofit.dart';
import 'package:student_app/widgets/student/student_form_screen.dart';
import 'package:student_app/widgets/student/student_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(StudentAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListScreen(),
      routes: {
        '/student': (ctx) => StudentListScreen(),
        '/student/form': (ctx) => StudentFormScreen(),
        '/add-student': (ctx) => AddStudentScreenWithRetrofit(),
      },
    );
  }
}

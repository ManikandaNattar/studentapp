import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_app/student.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> _studentList = [];

  @override
  void initState() {
    _getStudentList();
    super.initState();
  }

  void _getStudentList() async {
    final data = await Hive.openBox<Student>('student');
    setState(() {
      _studentList = data.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.engineering,
            color: Colors.white,
          ),
          title: Text(
            'Student App',
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: _studentList.length,
              itemBuilder: (context, idx) {
                Student student = _studentList[idx];
                return Card(
                  elevation: 5.0,
                  child: Container(
                    width: double.infinity,
                    child: ListTile(
                      title: Text(
                        student.studentName,
                      ),
                      subtitle: Text(
                        student.rollNo.toString(),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pushNamed(
                                '/student/form',
                                arguments: {
                                  'stud': student,
                                  'pos': idx,
                                },
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Delete Student',
                                      ),
                                      content: Text(
                                        'Are you sure want to delete?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text(
                                            'No',
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            final hiveDB =
                                                Hive.box<Student>('student');
                                            hiveDB.deleteAt(idx);
                                            setState(() {
                                              _studentList.removeAt(idx);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Yes',
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/add-student'),
            child: Text(
              'Add Student Using Retrofit',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(
            '/student/form',
          ),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      onWillPop: () async {
        exit(0);
      },
    );
  }
}

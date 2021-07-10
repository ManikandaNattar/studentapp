import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_app/student.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({Key? key}) : super(key: key);

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _studentNameController = TextEditingController();
  TextEditingController _rollNoController = TextEditingController();
  Student student = Student();
  Student studentData = Student();
  Map arguments = {};
  int pos = 0;
  int studentId = 0;

  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      arguments = args as Map;
      studentData = arguments['stud'] as Student;
      studentId = studentData.id;
      pos = arguments['pos'];
      _getFormData();
    }
    super.didChangeDependencies();
  }

  void _getFormData() {
    _studentNameController.text = studentData.studentName;
    _rollNoController.text = studentData.rollNo.toString();
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var box = await Hive.openBox<Student>('student');
      if (studentId == 0) {
        student.id = box.values.length + 1;
        box.add(student);
      } else {
        box.putAt(
          pos,
          student,
        );
      }
      Navigator.of(context).pushNamed('/student');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _studentNameController.text.isEmpty ? 'Add Student' : 'Edit Student',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'STUDENT INFO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _studentNameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Name should not be empty!';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                student.studentName = val.toString();
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: _rollNoController,
                              decoration: InputDecoration(
                                labelText: 'Roll No',
                                border: OutlineInputBorder(),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Roll No should not be empty!';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                student.rollNo = int.parse(val.toString());
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            ElevatedButton(
                              onPressed: () => _onSubmit(),
                              child: Text(
                                'SAVE',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

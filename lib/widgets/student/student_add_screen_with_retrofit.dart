import 'package:flutter/material.dart';
import 'package:student_app/widgets/student/api_service.dart';
import 'package:dio/dio.dart' as dio;

class AddStudentScreenWithRetrofit extends StatefulWidget {
  const AddStudentScreenWithRetrofit({Key? key}) : super(key: key);

  @override
  _AddStudentScreenWithRetrofitState createState() =>
      _AddStudentScreenWithRetrofitState();
}

class _AddStudentScreenWithRetrofitState
    extends State<AddStudentScreenWithRetrofit> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  Future<void> _onSave() async {
    final Map<String, dynamic> formData = {
      'name': _nameController.text,
      'age': _ageController.text,
    };
    ApiService apiService = ApiService(dio.Dio());
    final resp = await apiService.studentCreate(
      formData,
    );
    if (resp.status == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            resp.message.toString(),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      _nameController.text = '';
      _ageController.text = '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            resp.message.toString(),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Student',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () {
                  _onSave();
                },
                child: Text(
                  'SAVE',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

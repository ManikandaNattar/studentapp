import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  int id = 0;

  @HiveField(1)
  String studentName = '';

  @HiveField(2)
  int rollNo = 0;
}

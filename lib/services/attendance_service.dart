import 'package:hive_ce/hive.dart';
import '../models/student.dart';

class AttendanceService {
  static final Box _studentBox = Hive.box('students');
  static final Box _attendanceBox = Hive.box('attendance');

  static List<Student> getStudents() {
    return _studentBox.values
        .map((e) => Student.fromMap(Map<dynamic, dynamic>.from(e)))
        .toList();
  }

  static Student? findStudent(String id) {
    final data = _studentBox.get(id);
    if (data == null) return null;
    return Student.fromMap(Map<dynamic, dynamic>.from(data));
  }

  static Future<void> saveStudent(Student student) async {
    await _studentBox.put(student.id, student.toMap());
  }

  static Future<bool> markPresent(String studentId) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final key = '$today-$studentId';

    if (_attendanceBox.containsKey(key)) {
      return false;
    }

    await _attendanceBox.put(key, {
      'studentId': studentId,
      'date': today,
      'timestamp': DateTime.now().toIso8601String(),
    });

    return true;
  }

  static List<Map<String, dynamic>> attendanceForDay(DateTime date) {
    final targetDate = date.toIso8601String().split('T')[0];
    return _attendanceBox.values
        .map((e) => Map<String, dynamic>.from(e))
        .where((e) => e['date'] == targetDate)
        .toList();
  }

  static int presentCount() {
    return attendanceForDay(DateTime.now()).length;
  }

  static int absentCount() {
    final totalActive = getStudents().where((s) => s.active).length;
    return totalActive - presentCount();
  }
}

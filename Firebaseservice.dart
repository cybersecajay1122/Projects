import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Student
  Future<void> addStudent(Student student) async {
    await _db.collection('students').doc(student.id).set(student.toMap());
  }

  // Get all students
  Stream<List<Student>> getStudents() {
    return _db.collection('students').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList());
  }

  // Add Attendance
  Future<void> markAttendance(String studentId, DateTime date, bool isPresent) async {
    await _db.collection('attendance').add({
      'studentId': studentId,
      'date': date,
      'isPresent': isPresent,
    });
  }

  // Get Attendance for a student
  Stream<List<Attendance>> getAttendance(String studentId) {
    return _db
        .collection('attendance')
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Attendance.fromFirestore(doc)).toList());
  }
}

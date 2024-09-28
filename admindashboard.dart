import 'package:flutter/material.dart';
import 'package:student_attendance/services/firestore_service.dart';
import 'package:student_attendance/screens/add_student.dart';
import 'package:student_attendance/screens/mark_attendance.dart';

class AdminDashboard extends StatelessWidget {
  final _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: StreamBuilder(
        stream: _firestoreService.getStudents(),
        builder: (context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var student = snapshot.data![index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.email),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentScreen()),
              );
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarkAttendanceScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

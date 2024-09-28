class Attendance {
  String studentId;
  DateTime date;
  bool isPresent;

  Attendance({required this.studentId, required this.date, required this.isPresent});

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'date': date,
      'isPresent': isPresent,
    };
  }

  factory Attendance.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Attendance(
      studentId: data['studentId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      isPresent: data['isPresent'] ?? false,
    );
  }
}

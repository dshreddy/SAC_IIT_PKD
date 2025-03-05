class Course {
  String code;
  String title;
  String category;
  String credits;
  String grade;
  String attendance;

  Course({
    required this.code,
    required this.title,
    required this.category,
    required this.credits,
    required this.grade,
    required this.attendance,
  });

  @override
  String toString() {
    return '$code - $title - Category: $category - Credits: ${credits} - Grade: $grade - Attendance: $attendance';
  }
}
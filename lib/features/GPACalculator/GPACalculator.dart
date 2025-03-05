import 'Course.dart';

class GPACalculator{
  /*
          Refer B.Tech Regulations 24.2 - 24.9 for more info : https://iitpkd.ac.in/programs
  * */
  final Map<String, int> gradePointMap = {
    "S": 10, "A": 9, "B": 8, "C": 7, "D": 6, "E": 4,
    "U": 0, "W": 0, "I": 0, "Y": 0, "N": 0, "P": 0, "F": 0,
  };
  final Map<String, int> electiveCatReqCredits = {
    "PME": 0, "SME": 0, "GCE": 0, "HSE": 0, "OE": 0
  };

  Map<int, List<Course>> _semesterCourses = {};
  double CGPA = 0.0;
  Map<int, double> semesterGPA = {};

  GPACalculator(this._semesterCourses) {
    _calculateSGPA();
    _calculateCGPA();
  }

  // All the courses done in the semester (even courses with U/I/W) will be considered for SGPA calculation
  void _calculateSGPA() {
    semesterGPA.clear();

    _semesterCourses.forEach((semester, courses) {
      double totalCredits = 0;
      double weightedGradePoints = 0;

      for (var course in courses) {
        if(course.grade == "P" || course.grade == "F" || course.grade == "Y" || course.grade == "N") continue;
        double? gradePoint = gradePointMap[course.grade]?.toDouble();
        double credits = double.tryParse(course.credits.toString()) ?? 0.0;
        if (gradePoint != null) {
          totalCredits += credits;
          weightedGradePoints += gradePoint * credits;
        }
      }

      semesterGPA[semester] = totalCredits > 0 ? weightedGradePoints / totalCredits : 0.0;
    });
  }

  void _calculateCGPA() {
    double totalCredits = 0;
    double weightedGradePoints = 0;

    List<Course> allCourses = _semesterCourses.values.expand((e) => e).toList();
    allCourses = _removeDuplicateFailedCourses(allCourses);

    for (var course in allCourses) {
      if(course.grade == "P" || course.grade == "F" || course.grade == "Y" || course.grade == "N") continue;
      double gradePoint = gradePointMap[course.grade]?.toDouble() ?? 0;
      double credits = double.tryParse(course.credits.toString()) ?? 0.0;
      if(gradePoint == 0 && _isElective(course)) {
        // Electives with fail grade will be ignored in CGPA calculation
        continue;
      }
      totalCredits += credits;
      weightedGradePoints += gradePoint * credits;
    }

    CGPA = totalCredits > 0 ? weightedGradePoints / totalCredits : 0.0;
  }


  List<Course> _removeDuplicateFailedCourses(List<Course> courses) {
    Map<String, Course> uniqueCourses = {};

    for (var curr in courses) {
      if (uniqueCourses.containsKey(curr.code)) {
        Course prev = uniqueCourses[curr.code]!;

        // Keep the course with the higher grade
        if (gradePointMap[prev.grade]! < gradePointMap[curr.grade]!) {
          uniqueCourses[curr.code] = curr;
        }
      } else {
        // First occurrence of the course
        uniqueCourses[curr.code] = curr;
      }
    }

    return uniqueCourses.values.toList();
  }

  bool _isElective(Course course) {
    return electiveCatReqCredits.containsKey(course.category);
  }

  double getSGPA(int semester) => semesterGPA[semester] ?? 0.0;
  double getCGPA() => CGPA;
}
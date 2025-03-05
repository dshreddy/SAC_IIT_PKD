import 'Course.dart';

class CGPAOptimiser {
  final Map<String, int> _gradePointMap = {
    "S": 10, "A": 9, "B": 8, "C": 7, "D": 6, "E": 4,
    "U": 0, "W": 0, "I": 0, "Y": 0, "N": 0, "P": 0, "F": 0,
  };

  final Map<String, double> _electiveCatReqCredits = {
    "PME": 0, "SME": 0, "GCE": 0, "HSE": 0, "OE": 0
  };

  Map<int, List<Course>> _semesterCourses = {};
  List<Course> _finalCourses = [];
  double _CGPA = 0.0;
  double _totalReqCredits = 0;

  CGPAOptimiser(Map<int, List<Course>> semesterCourses, int total, int pme, int gce, int sme, int hse, int oe) {
    _semesterCourses = semesterCourses;
    _totalReqCredits = total.toDouble();
    _electiveCatReqCredits["PME"] = pme.toDouble();
    _electiveCatReqCredits["GCE"] = gce.toDouble();
    _electiveCatReqCredits["SME"] = sme.toDouble();
    _electiveCatReqCredits["HSE"] = hse.toDouble();
    _electiveCatReqCredits["OE"] = oe.toDouble();

    _calculateMAXCGPA();
  }

  void _calculateMAXCGPA() {
    double totalCredits = 0;
    double weightedGradePoints = 0;

    List<Course> allCourses = _semesterCourses.values.expand((e) => e).toList();
    allCourses = _removeDuplicateFailedCourses(allCourses);

    // Process Core Courses (excluding electives)
    for (var course in allCourses) {
      if (_isElective(course)) continue;
      if(course.grade == "P" || course.grade == "F" || course.grade == "Y" || course.grade == "N") continue;
      double gradePoint = _gradePointMap[course.grade]?.toDouble() ?? 0;
      double credits = double.tryParse(course.credits.toString()) ?? 0.0;
      totalCredits += credits;
      weightedGradePoints += gradePoint * credits;
    }

    // Get all electives
    List<Course> electives = allCourses.where((c) => _isElective(c)).toList();

    // Recursively find the best subset of electives
    _findBestElectiveSubset([], electives, 0, {}, totalCredits, weightedGradePoints);
  }

  void _findBestElectiveSubset(List<Course> subset, List<Course> electives, int i, Map<String, double> catCredits, double totalCredits, double weightedGradePoints) {
    if (i == electives.length) {
      // Check if all required credits are met
      if (_areElectiveCreditsMet(catCredits) && totalCredits >= _totalReqCredits) {
        double currCGPA = weightedGradePoints / totalCredits;
        if (currCGPA > _CGPA) {
          _CGPA = currCGPA;
          _finalCourses = List.of(subset); // Save the best selection
        }
      }
      return;
    }

    // Don't pick the current elective
    _findBestElectiveSubset(subset, electives, i + 1, Map.of(catCredits), totalCredits, weightedGradePoints);

    // Pick the current elective
    Course current = electives[i];
    double credits = current.credits as double;
    double newTotalCredits = totalCredits + credits;
    double newWeightedGradePoints = weightedGradePoints + (_gradePointMap[current.grade]!.toDouble() * credits);
    Map<String, double> newCatCredits = Map.of(catCredits);
    newCatCredits[current.category] = (newCatCredits[current.category] ?? 0) + credits;
    _findBestElectiveSubset([...subset, current], electives, i + 1, newCatCredits, newTotalCredits, newWeightedGradePoints);
  }

  bool _areElectiveCreditsMet(Map<String, double> catCredits) {
    for (var category in _electiveCatReqCredits.keys) {
      if ((catCredits[category] ?? 0) < _electiveCatReqCredits[category]!) {
        return false;
      }
    }
    return true;
  }

  List<Course> _removeDuplicateFailedCourses(List<Course> courses) {
    Map<String, Course> uniqueCourses = {};

    for (var curr in courses) {
      if (uniqueCourses.containsKey(curr.code)) {
        Course prev = uniqueCourses[curr.code]!;

        // Keep the course with the higher grade
        if (_gradePointMap[prev.grade]! < _gradePointMap[curr.grade]!) {
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
    return _electiveCatReqCredits.containsKey(course.category);
  }

  double getOptimizedCGPA() => _CGPA;
  List<Course> getOptimizedCourseList() => _finalCourses;
}

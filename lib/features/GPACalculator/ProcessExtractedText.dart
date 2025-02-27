import 'dart:core';

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

class ProcessExtractedText {
  String extractedText;
  Map<int, List<Course>> semesterCourses = {};

  ProcessExtractedText(this.extractedText) {
    _processText();
  }

  void _processText() {
    List<String> lines = extractedText.split('\n');
    int currentSemester = 0;

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();

      if (line.startsWith("Semester")) {
        // Extract semester number
        List<String> parts = line.split(' ');
        if (parts.length > 1) {
          currentSemester = int.tryParse(parts[1]) ?? 0;
        }
        // Only initialize if it hasn't been created already
        semesterCourses.putIfAbsent(currentSemester, () => []);
      } else if (currentSemester > 0 && _isCourseCode(line)) {
        // Extract course details
        String courseCode = line;
        int x = _findCreditsIndex(lines, i + 1);

        if (x == -1) continue; // Skip if credits not found

        String title = _extractCourseTitle(lines, i + 1, i + x - 1);
        String category = lines[i + x].trim();
        String credits = lines[i + x + 1].trim();
        String grade = lines[i + x + 2].trim();
        String attendance = lines[i+x+3].trim();

        Course c = Course(
          code: courseCode,
          title: title,
          category: category,
          credits: credits,
          grade: grade,
          attendance: attendance,
        );

        semesterCourses[currentSemester]?.add(c);
        i += x + 2; // Skip processed lines
      }
    }
  }

  bool _isCourseCode(String line) {
    return RegExp(r'^[A-Z]{2,}[0-9]+').hasMatch(line);
  }

  int _findCreditsIndex(List<String> lines, int startIndex) {
    for (int j = startIndex; j < lines.length; j++) {
      if (RegExp(r'^\d+(\.\d+)?$').hasMatch(lines[j].trim())) {
        return j - startIndex; // Return relative index from `i`
      }
    }
    return -1; // Not found
  }

  String _extractCourseTitle(List<String> lines, int start, int end) {
    return lines.sublist(start, end + 1).map((e) => e.trim()).join(' ');
  }

  void printCourses() {
    semesterCourses.forEach((semester, courses) {
      print("Semester $semester:");
      for (var course in courses) {
        print("  - ${course}");
      }
    });
  }
}

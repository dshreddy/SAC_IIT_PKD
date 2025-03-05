import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/features/GPACalculator/GPACalculator.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'Course.dart';
import 'ProcessExtractedText.dart';

class GPACalculatorScreen extends StatefulWidget {
  const GPACalculatorScreen({super.key});
  static String id = "gpa_calc_screen";

  @override
  _GPACalculatorScreenState createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
  Map<int, List<Course>> _semesterCourses = {};
  ProcessExtractedText _processor = ProcessExtractedText("");
  GPACalculator _gpaCalculator = GPACalculator({});

  int? selectedSemester;
  String? selectedCategory;
  String? selectedGrade;
  double? selectedCredits;

  Future<void> pickAndExtractPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      List<int> bytes = await file.readAsBytes();

      final PdfDocument document = PdfDocument(inputBytes: bytes);
      String text = PdfTextExtractor(document).extractText();
      document.dispose();

      setState(() {
        _processor = ProcessExtractedText(text);
        _semesterCourses = _processor.semesterCourses;
        // Compute GPA after extraction
        _gpaCalculator = GPACalculator(_semesterCourses);
      });
    }
  }

  List<Course> getFilteredCourses() {
    List<Course> allCourses = _semesterCourses.entries
        .expand((entry) => entry.value)
        .toList();

    return allCourses.where((course) {
      bool matchesSemester =
          selectedSemester == null || _semesterCourses[selectedSemester]?.contains(course) == true;
      bool matchesCategory =
          selectedCategory == null || course.category == selectedCategory;
      bool matchesGrade =
          selectedGrade == null || course.grade == selectedGrade;
      bool matchesCredits =
          selectedCredits == null || course.credits == selectedCredits;

      return matchesSemester && matchesCategory && matchesGrade && matchesCredits;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Course> displayedCourses = getFilteredCourses();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("GPA Calculator"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: pickAndExtractPDF,
                child: const Text("Select PDF"),
              ),
              const SizedBox(height: 16),

              // Display CGPA & SGPA above filters
              if (_semesterCourses.isNotEmpty) ...[
                Text("CGPA: ${_gpaCalculator.getCGPA().toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _semesterCourses.keys.map((sem) => Text(
                    "Semester $sem GPA: ${_gpaCalculator.getSGPA(sem).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16),
                  )).toList(),
                ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),

              // FILTER OPTIONS
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  DropdownButton<int>(
                    value: selectedSemester,
                    hint: const Text("Filter by Semester"),
                    items: _semesterCourses.keys
                        .map((sem) => DropdownMenuItem<int>(
                      value: sem,
                      child: Text("Semester $sem"),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedSemester = val;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedCategory,
                    hint: const Text("Filter by Category"),
                    items: _getUniqueCategories()
                        .map((cat) => DropdownMenuItem<String>(
                      value: cat,
                      child: Text(cat),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedGrade,
                    hint: const Text("Filter by Grade"),
                    items: _getUniqueGrades()
                        .map((grade) => DropdownMenuItem<String>(
                      value: grade,
                      child: Text(grade),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedGrade = val;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // COURSE TABLE
              Expanded(
                child: displayedCourses.isEmpty
                    ? const Center(child: Text("No courses available"))
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Code")),
                      DataColumn(label: Text("Title")),
                      DataColumn(label: Text("Category")),
                      DataColumn(label: Text("Credits")),
                      DataColumn(label: Text("Grade")),
                      DataColumn(label: Text("Attendance")),
                    ],
                    rows: displayedCourses.map((course) {
                      return DataRow(cells: [
                        DataCell(Text(course.code)),
                        DataCell(Text(course.title)),
                        DataCell(Text(course.category)),
                        DataCell(Text(course.credits.toString())),
                        DataCell(Text(course.grade)),
                        DataCell(Text(course.attendance)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getUniqueCategories() {
    return _semesterCourses.values
        .expand((courses) => courses.map((c) => c.category))
        .toSet()
        .toList();
  }

  List<String> _getUniqueGrades() {
    return _semesterCourses.values
        .expand((courses) => courses.map((c) => c.grade))
        .toSet()
        .toList();
  }
}

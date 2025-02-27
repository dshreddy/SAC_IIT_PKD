import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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

  Future<void> pickAndExtractPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      // Read file bytes
      File file = File(result.files.single.path!);
      List<int> bytes = await file.readAsBytes();

      // Load the PDF document
      final PdfDocument document = PdfDocument(inputBytes: bytes);

      //Extract the text from all the pages.
      String text = PdfTextExtractor(document).extractText();
      //Dispose the document.
      document.dispose();
      _processor = ProcessExtractedText(text);
      _processor.printCourses();
      _semesterCourses = _processor.semesterCourses;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}

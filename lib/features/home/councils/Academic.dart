import 'package:flutter/material.dart';

class AcademicScreen extends StatelessWidget {
  const AcademicScreen({super.key});
  static String id = "academics_screen";
  final String acadSecContent = ""
      "..efhujewlnfkmfe mlnkwemfewkcewnkwefnknkfeenfeknkefnklefnkl..";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Academics"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Image.asset(
                  "assets/images/not_found.jpg",
              ),
              Column(
                children: [
                  const Text("Link 1"),
                  const Text("Link 1"),
                  const Text("Link 1"),
                ],
              ),
              const SizedBox(height: 10),
              Text(acadSecContent),
            ]
          ),
        ),
    );
  }
}

import 'package:flutter/material.dart';

class TechnicalScreen extends StatelessWidget {
  const TechnicalScreen({super.key});
  static String id = "technical_screen";
  final String techSecContent = ""
      "..efhujewlnfkmfe mlnkwemfewkcewnkwefnknkfeenfeknkefnklefnkl..";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Technical"),
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
              Text(techSecContent),
            ]
        ),
      ),
    );
  }
}

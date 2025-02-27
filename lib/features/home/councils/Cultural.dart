import 'package:flutter/material.dart';

class CulturalScreen extends StatelessWidget {
  const CulturalScreen({super.key});
  static String id = "cultural_screen";
  final String culturalSecContent = ""
      "..efhujewlnfkmfe mlnkwemfewkcewnkwefnknkfeenfeknkefnklefnkl..";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Culturals"),
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
              Text(culturalSecContent),
            ]
        ),
      ),
    );
  }
}

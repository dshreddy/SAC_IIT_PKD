import 'package:flutter/material.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});
  static String id = "sports_screen";
  final String sportsSecContent = ""
      "..efhujewlnfkmfe mlnkwemfewkcewnkwefnknkfeenfeknkefnklefnkl..";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sports"),
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
              Text(sportsSecContent),
            ]
        ),
      ),
    );
  }
}


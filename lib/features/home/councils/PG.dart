import 'package:flutter/material.dart';

class PGScreen extends StatelessWidget {
  const PGScreen({super.key});
  static String id = "pg_screen";
  final String pgSecContent = ""
      "..efhujewlnfkmfe mlnkwemfewkcewnkwefnknkfeenfeknkefnklefnkl..";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PG"),
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
              Text(pgSecContent),
            ]
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HostelScreen extends StatelessWidget {
  const HostelScreen({super.key});
  static String id = "hostel_screen";
  final String hostellSecContent = ""
      "..efhujewlnfkmfe mlnkwemfewkcewnkwefnknkfeenfeknkefnklefnkl..";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hostel"),
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
              Text(hostellSecContent),
            ]
        ),
      ),
    );
  }
}

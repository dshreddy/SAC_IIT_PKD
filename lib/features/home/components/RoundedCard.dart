import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final String asset;
  final String title;

  const RoundedCard({super.key, required this.asset, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(asset, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

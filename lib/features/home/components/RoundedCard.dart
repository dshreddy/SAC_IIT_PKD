import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final String asset;
  final String title;
  final String id;

  const RoundedCard({super.key, required this.asset, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, id)
      },
      child: Card(
        child: ListTile(
          leading: Image.asset(
            asset,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/not_found.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              );
            },
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

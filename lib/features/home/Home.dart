import 'package:flutter/material.dart';
import 'components/RoundedCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> cardData = const [
    {'asset': 'assets/images/academics.jpg', 'title': 'Academics'},
    {'asset': 'assets/images/research.jpg', 'title': 'Research'},
    // {'asset': 'assets/general.png', 'title': 'General'},
    // {'asset': 'assets/culturals.png', 'title': 'Culturals'},
    // {'asset': 'assets/sports.png', 'title': 'Sports'},
    // {'asset': 'assets/technical.png', 'title': 'Technical'},
    // {'asset': 'assets/pg.png', 'title': 'PG'},
    // {'asset': 'assets/hostel.png', 'title': 'Hostel'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          return RoundedCard(
            asset: cardData[index]['asset']!,
            title: cardData[index]['title']!,
          );
        },
      ),
    );
  }
}

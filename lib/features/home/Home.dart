import 'package:flutter/material.dart';
import 'councils/Cultural.dart';
import 'councils/Hostel.dart';
import 'councils/PG.dart';
import 'councils/Research.dart';
import 'councils/SGS.dart';
import 'councils/Sports.dart';
import 'councils/Technical.dart';
import 'councils/Academic.dart';
import 'components/RoundedCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = "home_screen";
  static List<Map<String, String>> cardData = [
    {
      'asset': 'assets/images/general.png',
      'title': 'SGS',
      'id': SGSScreen.id
    },
    {
      'asset': 'assets/images/academics.jpg',
      'title': 'Academics',
      'id': AcademicScreen.id
    },
    {
      'asset': 'assets/images/culturals.png',
      'title': 'Culturals',
      'id': CulturalScreen.id
    },
    {
      'asset': 'assets/images/hostel.png',
      'title': 'Hostel',
      'id': HostelScreen.id
    },
    {
      'asset': 'assets/images/pg.png',
      'title': 'PG',
      'id': PGScreen.id
    },
    {
      'asset': 'assets/images/research.jpg',
      'title': 'Research',
      'id': ResearchScreen.id
    },
    {
      'asset': 'assets/images/sports.png',
      'title': 'Sports',
      'id': SportsScreen.id
    },
    {
      'asset': 'assets/images/technical.png',
      'title': 'Technical',
      'id': TechnicalScreen.id
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardData.length,
      itemBuilder: (context, index) {
        return RoundedCard(
            asset: cardData[index]['asset']!,
            title: cardData[index]['title']!,
            id: cardData[index]['id'] ?? id,
          );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/councils/Cultural.dart';
import 'package:flutter_application_1/features/home/councils/Hostel.dart';
import 'package:flutter_application_1/features/home/councils/PG.dart';
import 'package:flutter_application_1/features/home/councils/Research.dart';
import 'package:flutter_application_1/features/home/councils/SGS.dart';
import 'package:flutter_application_1/features/home/councils/Sports.dart';
import 'package:flutter_application_1/features/home/councils/Technical.dart';
import 'package:flutter_application_1/features/GPACalculator/UI.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'firebase_options.dart';

import '../features/theme/ThemeProvider.dart';
import '../features/auth/AuthScreen.dart';
import '../features/bottom_nav_bar/BottomNavBar.dart';
import '../features/calender/Calender.dart';
import 'features/home/councils/Academic.dart';
import '../features/home/Home.dart';
import '../features/profile/Profile.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
            // initialRoute: AuthScreen.id,
            initialRoute: GPACalculatorScreen.id,
            routes: {
              // Auth
              AuthScreen.id: (context) => AuthScreen(),

              // Bottom Nav Bar
              BottomNavBar.id: (context) => AuthScreen(),

              // Home
              HomeScreen.id: (context) => HomeScreen(),
              SGSScreen.id: (context) => SGSScreen(),
              AcademicScreen.id: (context) => AcademicScreen(),
              CulturalScreen.id: (context) => CulturalScreen(),
              HostelScreen.id: (context) => HostelScreen(),
              PGScreen.id: (context) => PGScreen(),
              ResearchScreen.id: (context) => ResearchScreen(),
              SportsScreen.id: (context) => SportsScreen(),
              TechnicalScreen.id: (context) => TechnicalScreen(),
              GPACalculatorScreen.id: (context) => GPACalculatorScreen(),

              // Calender
              CalenderScreen.id: (context) => CalenderScreen(),

              // Profile
              ProfileScreen.id: (context) => ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}

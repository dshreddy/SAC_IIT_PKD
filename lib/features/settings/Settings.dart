import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/theme/ThemeProvider.dart';
import '../auth/AuthScreen.dart';
import '../auth/AuthService.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: user != null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL ?? ''),
            radius: 50,
          ),
          SizedBox(height: 10),
          Text(user.displayName ?? 'No Name', style: TextStyle(fontSize: 18)),
          SizedBox(height: 5),
          Text(user.email ?? 'No Email', style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await AuthService().signout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
            child: Text('Sign Out'),
          ),
          ElevatedButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            child: Text('Toggle Theme'),
          ),
        ],
      )
          : Text('No user signed in', style: TextStyle(fontSize: 18)),
    );
  }
}

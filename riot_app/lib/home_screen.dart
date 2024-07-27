import 'package:flutter/material.dart';
import 'summoner_search.dart';
import 'favorite_summoners.dart';
import 'summoner_details.dart';
import 'user_storage.dart'; // Ensure this is the correct import
import 'login_screen.dart'; // Import the login screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: UserStorageService().getUserData('userName'), // Updated to use UserStorageService
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Home');
            } else {
              return Text('Welcome, ${snapshot.data ?? 'User'}');
            }
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SummonerSearchScreen()),
                );
              },
              child: const Text('Summoner Search'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteSummonersScreen()),
                );
              },
              child: const Text('Favorite Summoners'),
            ),
            ElevatedButton(
              onPressed: () async {
                await UserStorageService().removeUserData('userName'); // Updated to use UserStorageService
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your actual login screen
                  (route) => false, // Remove all routes from the stack
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

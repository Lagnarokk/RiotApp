import 'package:flutter/material.dart';
import 'summoner_search.dart';
import 'favorite_summoners.dart';
import 'summoner_details.dart';
import 'user_storage.dart';
import 'login_screen.dart';
import 'about.dart';  // Import the about screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Set the background color
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
        backgroundColor: Colors.blue, // Blue background color
        foregroundColor: Colors.white, // White text color
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Welcome to League Partner! If you want to add a Summoner to Favorites, go to the Summoner Search button!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24), // Add some space between the text and the buttons
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SummonerSearchScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue tone for the button
                foregroundColor: Colors.white, // White text color
              ),
              icon: Icon(Icons.search),
              label: const Text('Summoner Search'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoriteSummonersScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue tone for the button
                foregroundColor: Colors.white, // White text color
              ),
              icon: Icon(Icons.star),
              label: const Text('Favorite Summoners'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()), // Navigate to About screen
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue tone for the button
                foregroundColor: Colors.white, // White text color
              ),
              icon: Icon(Icons.info),
              label: const Text('About'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await UserStorageService().removeUserData('userName'); // Updated to use UserStorageService
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your actual login screen
                  (route) => false, // Remove all routes from the stack
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red tone for the logout button
                foregroundColor: Colors.white, // White text color
              ),
              icon: Icon(Icons.power_settings_new),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

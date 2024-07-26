import 'package:flutter/material.dart';

class FavoriteSummonersScreen extends StatelessWidget {
  const FavoriteSummonersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Summoners'),
      ),
      body: const Center(
        child: Text('No favorite summoners added yet.'),
      ),
    );
  }
}

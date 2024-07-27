import 'package:flutter/material.dart';
import 'summoner_details.dart';

class SummonerSearchScreen extends StatefulWidget {
  @override
  _SummonerSearchScreenState createState() => _SummonerSearchScreenState();
}

class _SummonerSearchScreenState extends State<SummonerSearchScreen> {
  final TextEditingController _gameNameController = TextEditingController();
  final TextEditingController _tagLineController = TextEditingController();

  String _selectedRegion = 'Select Region';
  String _selectedSubregion = 'Select Subregion';

  void _searchSummoner() {
    final gameName = _gameNameController.text;
    final tagLine = _tagLineController.text;
    if (gameName.isNotEmpty && tagLine.isNotEmpty && _selectedRegion != 'Select Region' && _selectedSubregion != 'Select Subregion') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummonerDetailsScreen(
            gameName: gameName,
            tagLine: tagLine,
            region: _selectedRegion,
            subregion: _selectedSubregion,
          ),
        ),
      );
    }
  }

  void _selectRegion(BuildContext context) async {
    final region = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: Text('AMERICAS'),
              onTap: () => Navigator.pop(context, 'AMERICAS'),
            ),
            ListTile(
              title: Text('ASIA'),
              onTap: () => Navigator.pop(context, 'ASIA'),
            ),
            ListTile(
              title: Text('ESPORTS'),
              onTap: () => Navigator.pop(context, 'ESPORTS'),
            ),
            ListTile(
              title: Text('EUROPE'),
              onTap: () => Navigator.pop(context, 'EUROPE'),
            ),
          ],
        );
      },
    );

    if (region != null) {
      setState(() {
        _selectedRegion = region;
      });
    }
  }

  void _selectSubregion(BuildContext context) async {
    final subregion = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: Text('BR1'),
              onTap: () => Navigator.pop(context, 'BR1'),
            ),
            ListTile(
              title: Text('EUN1'),
              onTap: () => Navigator.pop(context, 'EUN1'),
            ),
            ListTile(
              title: Text('EUW1'),
              onTap: () => Navigator.pop(context, 'EUW1'),
            ),
            ListTile(
              title: Text('JP1'),
              onTap: () => Navigator.pop(context, 'JP1'),
            ),
            ListTile(
              title: Text('KR'),
              onTap: () => Navigator.pop(context, 'KR'),
            ),
            ListTile(
              title: Text('LA1'),
              onTap: () => Navigator.pop(context, 'LA1'),
            ),
            ListTile(
              title: Text('LA2'),
              onTap: () => Navigator.pop(context, 'LA2'),
            ),
            ListTile(
              title: Text('ME1'),
              onTap: () => Navigator.pop(context, 'ME1'),
            ),
            ListTile(
              title: Text('NA1'),
              onTap: () => Navigator.pop(context, 'NA1'),
            ),
            ListTile(
              title: Text('OC1'),
              onTap: () => Navigator.pop(context, 'OC1'),
            ),
            ListTile(
              title: Text('PH2'),
              onTap: () => Navigator.pop(context, 'PH2'),
            ),
            ListTile(
              title: Text('RU'),
              onTap: () => Navigator.pop(context, 'RU'),
            ),
            ListTile(
              title: Text('SG2'),
              onTap: () => Navigator.pop(context, 'SG2'),
            ),
            ListTile(
              title: Text('TH2'),
              onTap: () => Navigator.pop(context, 'TH2'),
            ),
            ListTile(
              title: Text('TR1'),
              onTap: () => Navigator.pop(context, 'TR1'),
            ),
            ListTile(
              title: Text('TW2'),
              onTap: () => Navigator.pop(context, 'TW2'),
            ),
            ListTile(
              title: Text('VN2'),
              onTap: () => Navigator.pop(context, 'VN2'),
            ),
          ],
        );
      },
    );

    if (subregion != null) {
      setState(() {
        _selectedSubregion = subregion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Set the background color
      appBar: AppBar(
        title: Text('Search Summoner'),
        backgroundColor: Colors.blue, // Blue background color
        foregroundColor: Colors.white, // White text color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _gameNameController,
              decoration: InputDecoration(
                labelText: 'Game Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _tagLineController,
              decoration: InputDecoration(
                labelText: 'Tag Line',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectRegion(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: _selectedRegion,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectSubregion(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: _selectedSubregion,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchSummoner,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue tone for the search button
                foregroundColor: Colors.white, // White text color
              ),
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

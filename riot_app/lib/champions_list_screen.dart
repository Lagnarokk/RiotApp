import 'package:flutter/material.dart';
import 'riot_api_service.dart';

class ChampionsListScreen extends StatefulWidget {
  const ChampionsListScreen({super.key});

  @override
  _ChampionsListScreenState createState() => _ChampionsListScreenState();
}

class _ChampionsListScreenState extends State<ChampionsListScreen> {
  List<dynamic>? _champions;

  @override
  void initState() {
    super.initState();
    _fetchChampions();
  }

  _fetchChampions() async {
    try {
      var champions = await RiotApiService().fetchChampions();
      setState(() {
        _champions = champions;
      });
    } catch (e) {
      setState(() {
        _champions = ['Failed to load champions'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Champions List'),
      ),
      body: _champions == null
          ? const Center(child: CircularProgressIndicator())
          : _champions!.contains('Failed to load champions')
              ? Center(child: Text('Failed to load champions'))
              : ListView.builder(
                  itemCount: _champions!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Champion ${_champions![index]['name']}'),
                    );
                  },
                ),
    );
  }
}

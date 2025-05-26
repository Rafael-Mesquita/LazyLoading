import 'package:flutter/material.dart';
import '../models/country.dart';

class DetailScreen extends StatelessWidget {
  final Country country;

  const DetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(country.flagUrl, width: 150)),
            const SizedBox(height: 24),
            Text("Moeda: ${country.currency}", style: const TextStyle(fontSize: 18)),
            Text("Língua: ${country.language}", style: const TextStyle(fontSize: 18)),
            Text("Região: ${country.region}", style: const TextStyle(fontSize: 18)),
            Text("Sub-região: ${country.subregion}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatefulWidget {
  final String url;
  const PokemonDetailScreen({super.key, required this.url});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  Map<String, dynamic>? detail;
  bool isLoading = false;

  Future<void> fetchDetail() async {
    setState(() => isLoading = true);

    final response = await http.get(Uri.parse(widget.url));

    if (response.statusCode == 200) {
      detail = json.decode(response.body);
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokemon Detail")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : detail == null
          ? const Center(child: Text("Tidak ada data"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail!['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.network(
                    detail!['sprites']['front_default'],
                    height: 120,
                  ),
                  const SizedBox(height: 10),
                  Text("Height: ${detail!['height']}"),
                  Text("Weight: ${detail!['weight']}"),
                ],
              ),
            ),
    );
  }
}

import 'dart:convert';
import 'dart:developer' as developer;
import 'package:pokemon_mobile/data/models/pokemon_models.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  final String baseUrl = "https://pokeapi.co/api/v2";

  Future<List<PokemonModel>> getAllPokemon() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pokemon'));
      final body = jsonDecode(response.body);

      developer.log(
        "GET ALL POKEMON: ${response.statusCode} | ${response.body}",
        name: "API",
      );

      if (response.statusCode == 200) {
        final List? dataList = body['results'];
        if (dataList == null) {
          throw Exception("Data list tidak ditemukan di response");
        }
        return dataList.map((e) => PokemonModel.fromJson(e)).toList();
      } else {
        throw Exception(body['message'] ?? "Gagal mengambil data pokemon");
      }
    } catch (e) {
      developer.log("Error Get All Pokemon: $e", name: "API");
      rethrow;
    }
  }

  Future<PokemonModel> getPokemonById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));
      final body = jsonDecode(response.body);
      developer.log(
        "Response Get Pokemon By Id: ${response.body}",
        name: "API",
      );
      if (response.statusCode == 200) {
        return PokemonModel.fromJson(body);
      } else {
        throw Exception(body['message'] ?? "Gagal Mendapatkan Data Pokemon");
      }
    } catch (e) {
      developer.log("Error Get Pokemon By Id: $e", name: "API");
      rethrow;
    }
  }
}

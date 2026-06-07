import 'package:flutter/material.dart';
import 'package:pokemon_mobile/data/models/pokemon_models.dart';
import 'package:pokemon_mobile/data/repository/pokemon_repository.dart';

class PokemonProvider extends ChangeNotifier {
  final PokemonRepository _repository = PokemonRepository();

  List<PokemonModel> _pokemon = [];
  List<PokemonModel> get pokemons => _pokemon;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchPokemons() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pokemon = await _repository.getAllPokemon();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}

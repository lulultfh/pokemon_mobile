import 'package:flutter/material.dart';
import 'package:pokemon_mobile/data/providers/pokemon_provider.dart';
import 'package:pokemon_mobile/screen/pokemon_detail.dart';
import 'package:provider/provider.dart';

class PokemonDashboard extends StatefulWidget {
  const PokemonDashboard({super.key});

  @override
  State<PokemonDashboard> createState() => _PokemonDashboardState();
}

class _PokemonDashboardState extends State<PokemonDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () =>
          Provider.of<PokemonProvider>(context, listen: false).fetchPokemons(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokémon List")),
      body: Consumer<PokemonProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          return ListView.builder(
            itemCount: provider.pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = provider.pokemons[index];

              return ListTile(
                title: Text(pokemon.name),
                subtitle: Text(pokemon.url),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PokemonDetailScreen(url: pokemon.url),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

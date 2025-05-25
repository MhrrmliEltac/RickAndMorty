import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/character_cardview.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesViewmodel>().getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavouritesViewmodel>();
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(title: "Favoriler"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child:
                viewModel.characters.isEmpty
                    ? const CircularProgressIndicator.adaptive()
                    : ListView.builder(
                      itemCount: viewModel.characters.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:
                          (context, index) => Column(
                            children:
                                viewModel.characters
                                    .map(
                                      (character) => CharacterCardview(
                                        charactersModel: character,
                                      ),
                                    )
                                    .toList(),
                          ),
                    ),
          ),
        ),
      ),
    );
  }
}

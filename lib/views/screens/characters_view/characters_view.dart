import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/character_cardview.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharactersViewmodel>().getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewmodel>();
    return Scaffold(
      appBar: AppBarWidget(title: 'Rick and Morty'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel),
              viewModel.charactersModdel == null
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: viewModel.charactersModdel!.characters.length,
                      itemBuilder:
                          (context, index) => Column(
                            children: [
                              CharacterCardview(
                                scrollController: _scrollController,
                                onLoadMore: viewModel.getCharacterMore,
                                charactersModel:
                                    viewModel
                                        .charactersModdel!
                                        .characters[index],
                              ),
                              viewModel.charactersModdel!.characters.length -
                                          1 ==
                                      index
                                  ? Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  )
                                  : SizedBox(),
                            ],
                          ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(
    BuildContext context,
    CharactersViewmodel viewModel,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: viewModel.searchCharacterByName,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          hintText: "Karakterlerde Ara",
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

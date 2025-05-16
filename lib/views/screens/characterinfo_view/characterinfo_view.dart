import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/views/screens/characterinfo_view/characterinfo_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/decorated_container.dart';
import 'package:rick_and_morty/views/widgets/episod_list_widget.dart';

class CharacterinfoView extends StatefulWidget {
  final Object? id;
  const CharacterinfoView({super.key, required this.id});

  @override
  State<CharacterinfoView> createState() => _CharacterinfoViewState();
}

class _CharacterinfoViewState extends State<CharacterinfoView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _readSingleCharacter();
    });
  }

  void _readSingleCharacter() {
    if (widget.id == null) return;

    Provider.of<CharacterInfoViewModel>(
      context,
      listen: false,
    ).getSingleCharacter(widget.id as int);
  }

  @override
  Widget build(BuildContext context) {
    final characterInfo = context.watch<CharacterInfoViewModel>();

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(title: "Karakter", backgroundTransparent: true),
        body: DecoratedContainer(
          topChild: _characterImage(
            context: context,
            characterInfo: characterInfo,
          ),
          child: Column(
            children: [
              const SizedBox(height: 13),
              _characterName(characterInfo: characterInfo),
              const SizedBox(height: 15),
              _characterProperty(
                context: context,
                characterInfo: characterInfo,
              ),
              const SizedBox(height: 38),
              EpisodListWidget(episodes: characterInfo.episodes),
            ],
          ),
        ),
      ),
    );
  }

  Wrap _characterProperty({
    required BuildContext context,
    required CharacterInfoViewModel characterInfo,
  }) {
    final CharactersModel? characters = characterInfo.character;
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      alignment: WrapAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Text(characters?.status ?? ''),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Text(characters?.origin.name ?? ''),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Text(characters?.gender ?? ''),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Text(characters?.species ?? ''),
        ),
      ],
    );
  }

  Container _characterImage({
    required BuildContext context,
    required CharacterInfoViewModel characterInfo,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 88),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-image.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Hero(
        tag: characterInfo.character?.image ?? "",
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: CircleAvatar(
            radius: 98,
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: CircleAvatar(
              radius: 95,
              backgroundImage:
                  characterInfo.character != null
                      ? NetworkImage(characterInfo.character!.image)
                      : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _characterName({required CharacterInfoViewModel characterInfo}) {
    final name = characterInfo.character?.name ?? '';
    return Text(
      name,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }
}

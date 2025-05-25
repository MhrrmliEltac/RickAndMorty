import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/views/screens/sections_view/section_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/character_cardview.dart';

class SectionInfoView extends StatefulWidget {
  final int id;
  const SectionInfoView({super.key, required this.id});

  @override
  State<SectionInfoView> createState() => _SectionInfoViewState();
}

class _SectionInfoViewState extends State<SectionInfoView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionViewModel>().getSingleEpisode(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final episodeViewModel = context.watch<SectionViewModel>().episode;
    final charactersByEpisodes =
        context.watch<SectionViewModel>().charactersByEpisodes;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          title: episodeViewModel?.episode ?? "Bölüm Detayı",
        ),
        body:
            charactersByEpisodes.isEmpty
                ? Center(child: CircularProgressIndicator.adaptive())
                : ListView.builder(
                  itemCount: charactersByEpisodes.length,
                  itemBuilder: (context, index) {
                    final character = charactersByEpisodes[index];
                    return CharacterCardview(charactersModel: character);
                  },
                ),
      ),
    );
  }
}

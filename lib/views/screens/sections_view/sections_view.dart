import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/views/screens/sections_view/section_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/decorated_container.dart';
import 'package:rick_and_morty/views/widgets/episod_list_widget.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionViewModel>().getAllEpisodesModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(title: "Bölümler", backgroundTransparent: true),
        body: DecoratedContainer(
          topChild: Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg-image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          child: Consumer<SectionViewModel>(
            builder: (context, value, child) {
              if (value.episodeModel == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return EpisodListWidget(
                  episodes: value.episodeModel?.results,
                  isShow: false,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

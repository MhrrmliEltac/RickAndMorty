import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/views/screens/locations_view/location_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/character_cardview.dart';

class LocationInfoView extends StatefulWidget {
  final int? id;
  const LocationInfoView({super.key, required this.id});

  @override
  State<LocationInfoView> createState() => _LocationInfoViewState();
}

class _LocationInfoViewState extends State<LocationInfoView> {
  @override
  void initState() {
    super.initState();
    context.read<LocationViewmodel>().getLocationById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final locationInfo = context.watch<LocationViewmodel>().singleLocationModel;
    final charactersByResidents =
        context.watch<LocationViewmodel>().charactersByResidents;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(title: locationInfo?.name ?? "Location Info"),
        body:
            locationInfo == null
                ? Center(child: CircularProgressIndicator.adaptive())
                : ListView.builder(
                  itemCount: charactersByResidents.length,
                  itemBuilder: (context, index) {
                    final character = charactersByResidents[index];
                    return CharacterCardview(charactersModel: character);
                  },
                ),
      ),
    );
  }
}

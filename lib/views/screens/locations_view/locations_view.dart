import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/views/screens/locations_view/location_viewmodel.dart';
import 'package:rick_and_morty/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty/views/widgets/decorated_container.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    super.initState();
    context.read<LocationViewmodel>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final locationModel = context.watch<LocationViewmodel>().locationModel;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(title: "Konumlar", backgroundTransparent: true),
        body:
            locationModel == null
                ? Center(child: CircularProgressIndicator.adaptive())
                : LocationListWidget(locationModel: locationModel),
      ),
    );
  }
}

class LocationListWidget extends StatelessWidget {
  const LocationListWidget({super.key, required this.locationModel});

  final LocationResponse? locationModel;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      topChild: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        // alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-image.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 30, left: 18, right: 18),
              itemCount:
                  locationModel!
                      .results
                      .length, // Replace with your data length
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.location_on, size: 35),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text(
                    locationModel!.results[index].name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locationModel!.results[index].type,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        locationModel!.results[index].dimension,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed:
                        () => context.go(
                          "/locations/locationInfo",
                          extra: locationModel!.results[index].id,
                        ),
                    icon: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 10,
                  endIndent: 35,
                  color: Theme.of(context).colorScheme.tertiary,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

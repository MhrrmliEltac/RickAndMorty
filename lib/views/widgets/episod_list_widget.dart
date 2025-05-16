import 'package:flutter/material.dart';

class EpisodListWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final episodes;
  const EpisodListWidget({super.key, required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bölümler (${episodes?.length ?? 0})",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (episodes == null)
              const Center(child: CircularProgressIndicator())
            else
              Flexible(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.face_retouching_natural_rounded,
                          size: 40,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
                        title: Text(
                          episodes[index].episode.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          episodes[index].name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      );
                    },
                    separatorBuilder:
                        (context, index) => const Divider(height: 0),
                    itemCount: episodes.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

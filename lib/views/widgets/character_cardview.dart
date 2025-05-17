import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/app/router.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/services/api_preferences.dart';

class CharacterCardview extends StatefulWidget {
  final CharactersModel charactersModel;
  final VoidCallback? onLoadMore;
  final ScrollController? scrollController;
  final bool isFavorited;

  const CharacterCardview({
    super.key,
    required this.charactersModel,
    this.onLoadMore,
    this.scrollController,
    this.isFavorited = false,
  });

  @override
  State<CharacterCardview> createState() => _CharacterCardviewState();
}

class _CharacterCardviewState extends State<CharacterCardview> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.isFavorited;
    _detectScrollBottom();
  }

  void _detectScrollBottom() {
    widget.scrollController?.addListener(() {
      final maxScroll = widget.scrollController!.position.maxScrollExtent;
      final currentPosition = widget.scrollController!.position.pixels;
      const int delta = 200;
      if (maxScroll - currentPosition <= delta) {
        if (widget.onLoadMore != null) {
          widget.onLoadMore!();
        }
      }
    });
  }

  void _favoriteCharacter() {
    if (isFavorited) {
      locator<ApiPreferences>().removeCharacter(widget.charactersModel.id);
      isFavorited = false;
    } else {
      locator<ApiPreferences>().saveCharacter(widget.charactersModel.id);
      isFavorited = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.go(
            AppRoutes.profileRoutes,
            extra: widget.charactersModel.id,
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: widget.charactersModel.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.charactersModel.image,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    ),
                  ),
                  SizedBox(width: 17),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.charactersModel.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 3),
                        _infoCharacterWidget(
                          context: context,
                          type: "Koken",
                          value: widget.charactersModel.origin.name,
                        ),
                        SizedBox(height: 3),
                        _infoCharacterWidget(
                          context: context,
                          type: "Durum",
                          value: "${widget.charactersModel.status}}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: _favoriteCharacter,
              icon:
                  isFavorited
                      ? Icon(Icons.bookmark)
                      : Icon(Icons.bookmark_border),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCharacterWidget({
    required BuildContext context,
    required String type,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

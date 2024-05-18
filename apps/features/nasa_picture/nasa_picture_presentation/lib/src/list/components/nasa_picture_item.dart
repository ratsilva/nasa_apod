import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

class NasaPictureItem extends StatelessWidget {
  final NasaPicture picture;

  const NasaPictureItem({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          displayColor: Theme.of(context).colorScheme.onSurface,
        );

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: picture.url,
              child: CachedNetworkImage(
                imageUrl: picture.url,
                fit: BoxFit.cover,
                cacheKey: picture.url,
                placeholder: (context, url) => Placeholder(),
                errorWidget: (context, url, error) => Placeholder(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CustomText(text: picture.title, style: textTheme.titleLarge!),
                const SizedBox(height: 4),
                _CustomText(text: picture.dateTime.toIso8601String(), style: textTheme.bodyMedium!),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

///
class _CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _CustomText({required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(text, style: style),
    );
  }
}

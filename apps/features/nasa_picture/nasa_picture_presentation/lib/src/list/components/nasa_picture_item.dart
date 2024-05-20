import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_foundation/core_foundation.dart';
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
              child: picture.isValidImage
                  ? CachedNetworkImage(
                      imageUrl: picture.url,
                      fit: BoxFit.cover,
                      cacheKey: picture.url,
                      placeholder: (context, url) => LinearProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Icon(Icons.error),
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
                _CustomText(
                    text: DateFormatter().formatddMMyyyy(picture.dateTime),
                    style: textTheme.bodyMedium!),
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

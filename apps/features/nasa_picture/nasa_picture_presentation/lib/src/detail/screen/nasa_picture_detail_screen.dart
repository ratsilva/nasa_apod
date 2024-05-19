import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../bloc/nasa_picture_detail_state.dart';

class NasaPictureDetailScreen extends StatelessWidget with Screen {
  final NasaPictureDetailState state;

  const NasaPictureDetailScreen({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Widget body;

    if (state.loading == true) {
      body = const _LoadingContent();
    } else if (state.error == true) {
      body = const _ErrorContent();
    } else {
      body = _SuccessContent(
        picture: state.picture!,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasa APOD - Detail'),
      ),
      body: SafeArea(
        child: Center(
          child: body,
        ),
      ),
    );
  }
}

///
class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

///
class _ErrorContent extends StatelessWidget {
  const _ErrorContent();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Ops, something went wrong...",
      textAlign: TextAlign.center,
    );
  }
}

///
class _SuccessContent extends StatelessWidget {
  final NasaPicture picture;

  const _SuccessContent({
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          displayColor: Theme.of(context).colorScheme.onSurface,
        );

    return Column(
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
              const SizedBox(height: 4),
              _CustomText(text: picture.explanation, style: textTheme.titleSmall!),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

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

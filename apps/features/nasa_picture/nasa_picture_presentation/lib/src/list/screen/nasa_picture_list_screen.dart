import 'package:core_architecture/core_architecture.dart';
import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import '../bloc/nasa_picture_list_state.dart';
import '../components/nasa_picture_grid_view.dart';
import '../components/nasa_picture_search_bar.dart';

class NasaPictureListScreen extends StatelessWidget with Screen {
  final NasaPictureListState state;
  final Function(String) onSearchChanged;
  final Function(NasaPicture, BuildContext) onItemTapped;

  const NasaPictureListScreen({
    required this.state,
    required this.onSearchChanged,
    required this.onItemTapped,
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
        pictures: state.picturesList,
        onSearchChanged: onSearchChanged,
        onItemTapped: onItemTapped,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasa APOD'),
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
  final List<NasaPicture> pictures;
  final Function(String) onSearchChanged;
  final Function(NasaPicture, BuildContext) onItemTapped;

  const _SuccessContent({
    required this.pictures,
    required this.onSearchChanged,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final gridView = NasaPictureGridView(
      pictures: pictures,
      onItemTapped: onItemTapped,
    );

    final searchBar = NasaPictureSearchBar(
      onChanged: onSearchChanged,
      hint: "Search by title or date",
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchBar,
          const SizedBox(height: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
              child: gridView,
            ),
          ),
        ],
      ),
    );
  }
}

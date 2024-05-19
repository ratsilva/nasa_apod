import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_item.dart';

///
class NasaPictureGridView extends StatelessWidget {
  final List<NasaPicture> pictures;
  final Function(NasaPicture, BuildContext) onItemTapped;
  final VoidCallback onListEndReached;

  const NasaPictureGridView({
    Key? key,
    required this.pictures,
    required this.onItemTapped,
    required this.onListEndReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pictures.isEmpty) {
      return Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(child: Image.asset("assets/images/empty-box.png", fit: BoxFit.contain)),
            const SizedBox(height: 16),
            Flexible(
              child: Text("Ops, no results found...", textAlign: TextAlign.center),
              flex: 3,
            ),
          ],
        ),
        ListView(),
      ]);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.columnCount,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        if (index == pictures.length - 3) {
          onListEndReached();
        }
        return GestureDetector(
          onTap: () => onItemTapped(pictures[index], context),
          child: NasaPictureItem(picture: pictures[index]),
        );
      },
    );
  }
}

///
extension on BuildContext {
  int get columnCount => _isMobile
      ? 1
      : _isTablet
          ? 2
          : 4;
  bool get _isMobile => MediaQuery.of(this).size.width <= 600;
  bool get _isTablet =>
      MediaQuery.of(this).size.width > 600 && MediaQuery.of(this).size.width <= 1200;
}

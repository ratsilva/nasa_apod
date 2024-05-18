import 'package:flutter/material.dart';
import 'package:nasa_picture_domain/nasa_picture_domain.dart';

import 'nasa_picture_item.dart';

///
class NasaPictureGridView extends StatelessWidget {
  final List<NasaPicture> pictures;
  final Function(NasaPicture) onItemTapped;

  const NasaPictureGridView({
    Key? key,
    required this.pictures,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.columnCount,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: pictures.length,
      itemBuilder: (_, int index) => GestureDetector(
        onTap: () => onItemTapped(pictures[index]),
        child: NasaPictureItem(picture: pictures[index]),
      ),
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

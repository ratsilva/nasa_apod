abstract class NasaPictureListEvent {}

class NasaPictureListStartEvent implements NasaPictureListEvent {}

class NasaPictureListSearchEvent implements NasaPictureListEvent {
  final String searchTerm;
  NasaPictureListSearchEvent(this.searchTerm);
}

class NasaPictureListNextPageEvent implements NasaPictureListEvent {}

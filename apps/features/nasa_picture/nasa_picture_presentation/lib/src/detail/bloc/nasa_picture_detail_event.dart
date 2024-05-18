abstract class NasaPictureDetailEvent {}

class NasaPictureDetailStartEvent implements NasaPictureDetailEvent {
  final DateTime dateTime;
  NasaPictureDetailStartEvent(this.dateTime);
}

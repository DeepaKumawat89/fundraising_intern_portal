import 'package:equatable/equatable.dart';

abstract class AnnouncementsEvent extends Equatable {
  const AnnouncementsEvent();

  @override
  List<Object?> get props => [];
}

class AnnouncementsLoadRequested extends AnnouncementsEvent {
  const AnnouncementsLoadRequested();
}

class AnnouncementsRefreshRequested extends AnnouncementsEvent {
  const AnnouncementsRefreshRequested();
}

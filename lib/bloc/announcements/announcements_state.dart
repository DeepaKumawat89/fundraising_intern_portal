import 'package:equatable/equatable.dart';
import '../../models/announcement.dart';

abstract class AnnouncementsState extends Equatable {
  const AnnouncementsState();

  @override
  List<Object?> get props => [];
}

class AnnouncementsInitial extends AnnouncementsState {
  const AnnouncementsInitial();
}

class AnnouncementsLoading extends AnnouncementsState {
  const AnnouncementsLoading();
}

class AnnouncementsLoaded extends AnnouncementsState {
  final List<Announcement> announcements;
  final bool isRefreshing;

  const AnnouncementsLoaded({
    required this.announcements,
    this.isRefreshing = false,
  });

  @override
  List<Object?> get props => [announcements, isRefreshing];

  AnnouncementsLoaded copyWith({
    List<Announcement>? announcements,
    bool? isRefreshing,
  }) {
    return AnnouncementsLoaded(
      announcements: announcements ?? this.announcements,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

class AnnouncementsError extends AnnouncementsState {
  final String message;

  const AnnouncementsError({required this.message});

  @override
  List<Object?> get props => [message];
}

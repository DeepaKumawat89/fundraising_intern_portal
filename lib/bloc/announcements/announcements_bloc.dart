import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/mock_data_service.dart';
import 'announcements_event.dart';
import 'announcements_state.dart';

class AnnouncementsBloc extends Bloc<AnnouncementsEvent, AnnouncementsState> {
  AnnouncementsBloc() : super(const AnnouncementsInitial()) {
    on<AnnouncementsLoadRequested>(_onLoadRequested);
    on<AnnouncementsRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onLoadRequested(
    AnnouncementsLoadRequested event,
    Emitter<AnnouncementsState> emit,
  ) async {
    emit(const AnnouncementsLoading());

    try {
      final announcements = await MockDataService.fetchAnnouncements();
      emit(AnnouncementsLoaded(announcements: announcements));
    } catch (e) {
      emit(
        AnnouncementsError(
          message: 'Failed to load announcements: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    AnnouncementsRefreshRequested event,
    Emitter<AnnouncementsState> emit,
  ) async {
    if (state is AnnouncementsLoaded) {
      final currentState = state as AnnouncementsLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      try {
        final announcements = await MockDataService.fetchAnnouncements();
        emit(
          AnnouncementsLoaded(
            announcements: announcements,
            isRefreshing: false,
          ),
        );
      } catch (e) {
        emit(
          AnnouncementsError(
            message: 'Failed to refresh announcements: ${e.toString()}',
          ),
        );
      }
    } else {
      add(const AnnouncementsLoadRequested());
    }
  }
}

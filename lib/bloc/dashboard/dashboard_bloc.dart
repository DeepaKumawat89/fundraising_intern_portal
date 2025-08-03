import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/mock_data_service.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<DashboardLoadRequested>(_onLoadRequested);
    on<DashboardRefreshRequested>(_onRefreshRequested);
    on<ReferralCodeCopyRequested>(_onReferralCodeCopyRequested);
  }

  Future<void> _onLoadRequested(
    DashboardLoadRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());

    try {
      final intern = await MockDataService.fetchCurrentIntern();
      emit(DashboardLoaded(intern: intern));
    } catch (e) {
      emit(
        DashboardError(message: 'Failed to load dashboard: ${e.toString()}'),
      );
    }
  }

  Future<void> _onRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(currentState.copyWith(isRefreshing: true));

      try {
        final intern = await MockDataService.fetchCurrentIntern();
        emit(DashboardLoaded(intern: intern, isRefreshing: false));
      } catch (e) {
        emit(
          DashboardError(
            message: 'Failed to refresh dashboard: ${e.toString()}',
          ),
        );
      }
    } else {
      add(const DashboardLoadRequested());
    }
  }

  Future<void> _onReferralCodeCopyRequested(
    ReferralCodeCopyRequested event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;

      try {
        await Clipboard.setData(
          ClipboardData(text: currentState.intern.referralCode),
        );
        emit(ReferralCodeCopied(intern: currentState.intern));

        // Return to loaded state after a brief moment
        await Future.delayed(const Duration(milliseconds: 1500));
        emit(DashboardLoaded(intern: currentState.intern));
      } catch (e) {
        emit(
          DashboardError(
            message: 'Failed to copy referral code: ${e.toString()}',
          ),
        );
      }
    }
  }
}

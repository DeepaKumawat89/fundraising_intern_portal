import 'package:equatable/equatable.dart';
import '../../models/intern.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final Intern intern;
  final bool isRefreshing;

  const DashboardLoaded({required this.intern, this.isRefreshing = false});

  @override
  List<Object?> get props => [intern, isRefreshing];

  DashboardLoaded copyWith({Intern? intern, bool? isRefreshing}) {
    return DashboardLoaded(
      intern: intern ?? this.intern,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReferralCodeCopied extends DashboardState {
  final Intern intern;

  const ReferralCodeCopied({required this.intern});

  @override
  List<Object?> get props => [intern];
}

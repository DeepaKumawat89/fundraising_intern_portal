import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String id;
  final String name;
  final double donations;
  final int rank;
  final String profileImage;
  final int referrals;

  const LeaderboardEntry({
    required this.id,
    required this.name,
    required this.donations,
    required this.rank,
    this.profileImage = '',
    required this.referrals,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    donations,
    rank,
    profileImage,
    referrals,
  ];

  LeaderboardEntry copyWith({
    String? id,
    String? name,
    double? donations,
    int? rank,
    String? profileImage,
    int? referrals,
  }) {
    return LeaderboardEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      donations: donations ?? this.donations,
      rank: rank ?? this.rank,
      profileImage: profileImage ?? this.profileImage,
      referrals: referrals ?? this.referrals,
    );
  }
}

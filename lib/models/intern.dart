import 'package:equatable/equatable.dart';

class Intern extends Equatable {
  final String id;
  final String name;
  final String email;
  final String referralCode;
  final double totalDonations;
  final int totalReferrals;
  final List<Reward> rewards;
  final String profileImage;

  const Intern({
    required this.id,
    required this.name,
    required this.email,
    required this.referralCode,
    required this.totalDonations,
    required this.totalReferrals,
    required this.rewards,
    this.profileImage = '',
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    referralCode,
    totalDonations,
    totalReferrals,
    rewards,
    profileImage,
  ];

  Intern copyWith({
    String? id,
    String? name,
    String? email,
    String? referralCode,
    double? totalDonations,
    int? totalReferrals,
    List<Reward>? rewards,
    String? profileImage,
  }) {
    return Intern(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      referralCode: referralCode ?? this.referralCode,
      totalDonations: totalDonations ?? this.totalDonations,
      totalReferrals: totalReferrals ?? this.totalReferrals,
      rewards: rewards ?? this.rewards,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class Reward extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isUnlocked;
  final String icon;
  final double requiredAmount;

  const Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.isUnlocked,
    required this.icon,
    required this.requiredAmount,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isUnlocked,
    icon,
    requiredAmount,
  ];

  Reward copyWith({
    String? id,
    String? title,
    String? description,
    bool? isUnlocked,
    String? icon,
    double? requiredAmount,
  }) {
    return Reward(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      icon: icon ?? this.icon,
      requiredAmount: requiredAmount ?? this.requiredAmount,
    );
  }
}

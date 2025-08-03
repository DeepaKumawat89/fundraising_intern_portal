import 'package:flutter/material.dart';
import '../models/intern.dart';
import '../theme/app_theme.dart';

class RewardsSection extends StatelessWidget {
  final List<Reward> rewards;

  const RewardsSection({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rewards & Achievements', style: AppTheme.headingSmall),
        const SizedBox(height: AppTheme.spacingMD),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppTheme.cardRadius,
            boxShadow: AppTheme.cardShadow,
          ),
          child: Column(
            children: [
              _buildProgressBar(),
              const SizedBox(height: AppTheme.spacingLG),
              ...rewards.map((reward) => _buildRewardItem(reward)).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    final unlockedCount = rewards.where((r) => r.isUnlocked).length;
    final progress = unlockedCount / rewards.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '$unlockedCount / ${rewards.length}',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingSM),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppTheme.surfaceColor,
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppTheme.primaryColor,
          ),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildRewardItem(Reward reward) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSM),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: reward.isUnlocked
                  ? AppTheme.primaryColor.withOpacity(0.1)
                  : AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: reward.isUnlocked
                  ? Border.all(color: AppTheme.primaryColor.withOpacity(0.3))
                  : null,
            ),
            child: Center(
              child: reward.isUnlocked
                  ? Text(reward.icon, style: const TextStyle(fontSize: 24))
                  : Icon(
                      Icons.lock_outline,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: reward.isUnlocked
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  reward.description,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (reward.isUnlocked)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSM,
                vertical: AppTheme.spacingXS,
              ),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Unlocked',
                style: AppTheme.captionText.copyWith(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Text(
              '\$${reward.requiredAmount.toStringAsFixed(0)}',
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

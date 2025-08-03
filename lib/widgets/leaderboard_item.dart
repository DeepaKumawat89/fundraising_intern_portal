import 'package:flutter/material.dart';
import '../models/leaderboard_entry.dart';
import '../theme/app_theme.dart';

class LeaderboardItem extends StatefulWidget {
  final LeaderboardEntry entry;
  final bool isLast;

  const LeaderboardItem({super.key, required this.entry, this.isLast = false});

  @override
  State<LeaderboardItem> createState() => _LeaderboardItemState();
}

class _LeaderboardItemState extends State<LeaderboardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start animation with delay based on rank
    Future.delayed(Duration(milliseconds: widget.entry.rank * 50), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = widget.entry.id == '1'; // Mock current user ID

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLG,
                vertical: AppTheme.spacingSM,
              ),
              padding: const EdgeInsets.all(AppTheme.spacingMD),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? AppTheme.primaryColor.withOpacity(0.05)
                    : Colors.transparent,
                border: isCurrentUser
                    ? Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        width: 1,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildRankBadge(),
                      const SizedBox(width: AppTheme.spacingMD),
                      Flexible(child: _buildProfileSection()),
                      const Spacer(),
                      _buildStatsSection(),
                    ],
                  ),
                  if (!widget.isLast)
                    Container(
                      margin: const EdgeInsets.only(top: AppTheme.spacingMD),
                      height: 1,
                      color: AppTheme.surfaceColor,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRankBadge() {
    Color rankColor;
    if (widget.entry.rank <= 3) {
      rankColor = AppTheme.warningColor;
    } else if (widget.entry.rank <= 5) {
      rankColor = AppTheme.primaryColor;
    } else {
      rankColor = AppTheme.textSecondary;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: rankColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: rankColor.withOpacity(0.3), width: 1),
      ),
      child: Center(
        child: Text(
          '#${widget.entry.rank}',
          style: AppTheme.bodyMedium.copyWith(
            color: rankColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    String displayName = widget.entry.name.length > 10
        ? widget.entry.name.substring(0, 9) + '...'
        : widget.entry.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              displayName,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          ],
        ),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          '${widget.entry.referrals} referrals',
          style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${widget.entry.donations.toStringAsFixed(0)}',
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXS),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.trending_up, size: 14, color: AppTheme.successColor),
            const SizedBox(width: 2),
            Text(
              '+12%',
              style: AppTheme.captionText.copyWith(
                color: AppTheme.successColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

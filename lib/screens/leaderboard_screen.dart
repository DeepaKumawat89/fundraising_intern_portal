import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/leaderboard/leaderboard_bloc.dart';
import '../bloc/leaderboard/leaderboard_event.dart';
import '../bloc/leaderboard/leaderboard_state.dart';
import '../models/leaderboard_entry.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/podium_widget.dart';
import '../widgets/leaderboard_item.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    context.read<LeaderboardBloc>().add(const LeaderboardLoadRequested());
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    context.read<LeaderboardBloc>().add(const LeaderboardRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<LeaderboardBloc, LeaderboardState>(
        listener: (context, state) {
          if (state is LeaderboardError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LeaderboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LeaderboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: AppTheme.spacingMD),
                  Text(
                    'Failed to load leaderboard',
                    style: AppTheme.headingMedium,
                  ),
                  const SizedBox(height: AppTheme.spacingSM),
                  Text(
                    state.message,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingLG),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LeaderboardBloc>().add(
                        const LeaderboardLoadRequested(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is LeaderboardLoaded) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                color: AppTheme.primaryColor,
                child: CustomScrollView(
                  slivers: [
                    const CustomAppBar(
                      title: 'Leaderboard',
                      subtitle: 'See how you rank against other interns',
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacingMD),
                        child: Column(
                          children: [
                            _buildPodium(state.topThree),
                            const SizedBox(height: AppTheme.spacingLG),
                            _buildRankingsList(state.remaining),
                            const SizedBox(height: AppTheme.spacingXL),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPodium(List<LeaderboardEntry> topThree) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.cardRadius,
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, color: AppTheme.warningColor, size: 24),
              const SizedBox(width: AppTheme.spacingSM),
              Text(
                'Top Performers',
                style: AppTheme.headingSmall.copyWith(
                  color: AppTheme.warningColor,
                ),
              ),
            ],
          ),
          PodiumWidget(topThree: topThree),
        ],
      ),
    );
  }

  Widget _buildRankingsList(List<LeaderboardEntry> remaining) {
    // Only mobile layout
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.cardRadius,
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            child: Text('Full Rankings', style: AppTheme.headingSmall),
          ),
          ...remaining.asMap().entries.map((entry) {
            final index = entry.key;
            final leaderboardEntry = entry.value;
            return LeaderboardItem(
              entry: leaderboardEntry,
              isLast: index == remaining.length - 1,
            );
          }).toList(),
        ],
      ),
    );
  }
}

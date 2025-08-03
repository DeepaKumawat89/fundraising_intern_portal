import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard/dashboard_bloc.dart';
import '../bloc/dashboard/dashboard_event.dart';
import '../bloc/dashboard/dashboard_state.dart';
import '../main.dart';
import '../models/intern.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_card.dart';
import '../widgets/referral_code_card.dart';
import '../widgets/rewards_section.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/responsive_layout.dart';
import '../utils/responsive_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    context.read<DashboardBloc>().add(const DashboardLoadRequested());
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _cardAnimations = List.generate(
      4,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            0.6 + (index * 0.1),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    context.read<DashboardBloc>().add(const DashboardRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is ReferralCodeCopied) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: AppTheme.spacingSM),
                    Text('Referral code copied to clipboard!'),
                  ],
                ),
                backgroundColor: AppTheme.successColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.buttonRadius,
                ),
              ),
            );
          }
          if (state is DashboardError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
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
                  Text('Something went wrong', style: AppTheme.headingMedium),
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
                      context.read<DashboardBloc>().add(
                        const DashboardLoadRequested(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is DashboardLoaded || state is ReferralCodeCopied) {
            final intern = state is DashboardLoaded
                ? state.intern
                : (state as ReferralCodeCopied).intern;

            return RefreshIndicator(
              onRefresh: _handleRefresh,
              color: AppTheme.primaryColor,
              child: CustomScrollView(
                slivers: [
                  CustomAppBar(
                    title: 'Dashboard',
                    subtitle: 'Welcome back, ${intern.name.split(' ').first}!',
                  ),
                  SliverToBoxAdapter(
                    child: ResponsiveContainer(
                      child: Padding(
                        padding: AppTheme.responsivePadding(context),
                        child: Column(
                          children: [
                            _buildStatsCards(intern),
                            SizedBox(
                              height: AppTheme.responsiveSpacingLG(context),
                            ),
                            _buildReferralSection(intern),
                            SizedBox(
                              height: AppTheme.responsiveSpacingLG(context),
                            ),
                            _buildRewardsSection(intern),
                            SizedBox(
                              height: AppTheme.responsiveSpacingXL(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatsCards(Intern intern) {
    final statsCardData = [
      {
        'title': 'Total Donations',
        'value': '\$${intern.totalDonations.toStringAsFixed(0)}',
        'icon': Icons.trending_up,
        'color': AppTheme.primaryColor,
        'animation': _cardAnimations[0],
      },
      {
        'title': 'Referrals',
        'value': '${intern.totalReferrals}',
        'icon': Icons.people,
        'color': AppTheme.secondaryColor,
        'animation': _cardAnimations[1],
      },
      {
        'title': 'This Month',
        'value': '\$${(intern.totalDonations * 0.3).toStringAsFixed(0)}',
        'icon': Icons.calendar_today,
        'color': AppTheme.successColor,
        'animation': _cardAnimations[2],
      },
      {
        'title': 'Rewards',
        'value': '${intern.rewards.where((r) => r.isUnlocked).length}',
        'icon': Icons.emoji_events,
        'color': AppTheme.warningColor,
        'animation': _cardAnimations[3],
      },
    ];

    // Only mobile layout
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: statsCardData[0]['animation'] as Animation<double>,
                builder: (context, child) {
                  return Transform.scale(
                    scale:
                        (statsCardData[0]['animation'] as Animation<double>)
                            .value,
                    child: StatsCard(
                      title: statsCardData[0]['title'] as String,
                      value: statsCardData[0]['value'] as String,
                      icon: statsCardData[0]['icon'] as IconData,
                      color: statsCardData[0]['color'] as Color,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: AppTheme.responsiveSpacingMD(context)),
            Expanded(
              child: AnimatedBuilder(
                animation: statsCardData[1]['animation'] as Animation<double>,
                builder: (context, child) {
                  return Transform.scale(
                    scale:
                        (statsCardData[1]['animation'] as Animation<double>)
                            .value,
                    child: StatsCard(
                      title: statsCardData[1]['title'] as String,
                      value: statsCardData[1]['value'] as String,
                      icon: statsCardData[1]['icon'] as IconData,
                      color: statsCardData[1]['color'] as Color,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.responsiveSpacingMD(context)),
        Row(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: statsCardData[2]['animation'] as Animation<double>,
                builder: (context, child) {
                  return Transform.scale(
                    scale:
                        (statsCardData[2]['animation'] as Animation<double>)
                            .value,
                    child: StatsCard(
                      title: statsCardData[2]['title'] as String,
                      value: statsCardData[2]['value'] as String,
                      icon: statsCardData[2]['icon'] as IconData,
                      color: statsCardData[2]['color'] as Color,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: AppTheme.responsiveSpacingMD(context)),
            Expanded(
              child: AnimatedBuilder(
                animation: statsCardData[3]['animation'] as Animation<double>,
                builder: (context, child) {
                  return Transform.scale(
                    scale:
                        (statsCardData[3]['animation'] as Animation<double>)
                            .value,
                    child: StatsCard(
                      title: statsCardData[3]['title'] as String,
                      value: statsCardData[3]['value'] as String,
                      icon: statsCardData[3]['icon'] as IconData,
                      color: statsCardData[3]['color'] as Color,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReferralSection(Intern intern) {
    return ReferralCodeCard(
      referralCode: intern.referralCode,
      onCopy: () {
        context.read<DashboardBloc>().add(const ReferralCodeCopyRequested());
      },
    );
  }

  Widget _buildRewardsSection(Intern intern) {
    return RewardsSection(rewards: intern.rewards);
  }
}

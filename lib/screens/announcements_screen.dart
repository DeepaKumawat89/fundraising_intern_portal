import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/announcements/announcements_bloc.dart';
import '../bloc/announcements/announcements_event.dart';
import '../bloc/announcements/announcements_state.dart';
import '../models/announcement.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/announcement_card.dart';
import '../widgets/announcement_detail_modal.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    context.read<AnnouncementsBloc>().add(const AnnouncementsLoadRequested());
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    context.read<AnnouncementsBloc>().add(
      const AnnouncementsRefreshRequested(),
    );
  }

  void _showAnnouncementDetail(Announcement announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnnouncementDetailModal(announcement: announcement),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<AnnouncementsBloc, AnnouncementsState>(
        listener: (context, state) {
          if (state is AnnouncementsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AnnouncementsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AnnouncementsError) {
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
                    'Failed to load announcements',
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
                      context.read<AnnouncementsBloc>().add(
                        const AnnouncementsLoadRequested(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AnnouncementsLoaded) {
            final announcements = state.announcements;

            if (announcements.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.announcement_outlined,
                      size: 64,
                      color: AppTheme.textSecondary,
                    ),
                    SizedBox(height: AppTheme.spacingMD),
                    Text(
                      'No announcements yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingSM),
                    Text(
                      'Check back later for updates',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: _handleRefresh,
              color: AppTheme.primaryColor,
              child: CustomScrollView(
                slivers: [
                  const CustomAppBar(
                    title: 'Announcements',
                    subtitle: 'Stay updated with the latest news',
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingMD),
                      child: Column(
                        children: [
                          _buildImportantNotice(announcements),
                          // const SizedBox(height: AppTheme.spacingLG),
                          _buildAnnouncementsList(announcements),
                          const SizedBox(height: AppTheme.spacingXL),
                        ],
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

  Widget _buildImportantNotice(List<Announcement> announcements) {
    final importantAnnouncements = announcements
        .where((announcement) => announcement.isImportant)
        .toList();

    if (importantAnnouncements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.warningColor.withOpacity(0.1),
            AppTheme.warningColor.withOpacity(0.05),
          ],
        ),
        borderRadius: AppTheme.cardRadius,
        border: Border.all(color: AppTheme.warningColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.priority_high, color: AppTheme.warningColor, size: 24),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Updates',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.warningColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  '${importantAnnouncements.length} important announcement${importantAnnouncements.length == 1 ? '' : 's'}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: announcements.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppTheme.spacingMD),
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
            ),
          ),
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
                  ),
                ),
            child: AnnouncementCard(
              announcement: announcement,
              onTap: () => _showAnnouncementDetail(announcement),
            ),
          ),
        );
      },
    );
  }
}

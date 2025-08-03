import '../models/intern.dart';
import '../models/leaderboard_entry.dart';
import '../models/announcement.dart';

class MockDataService {
  static const String _currentInternId = '1';

  // Mock current intern data
  static Intern getCurrentIntern() {
    return Intern(
      id: _currentInternId,
      name: 'Sarah Johnson',
      email: 'sarah.johnson@internraise.com',
      referralCode: 'SARAH2024',
      totalDonations: 15750.00,
      totalReferrals: 23,
      profileImage: '',
      rewards: getRewards(),
    );
  }

  // Mock rewards data
  static List<Reward> getRewards() {
    return [
      const Reward(
        id: '1',
        title: 'First Steps',
        description: 'Complete your first donation',
        isUnlocked: true,
        icon: '🎯',
        requiredAmount: 100.0,
      ),
      const Reward(
        id: '2',
        title: 'Rising Star',
        description: 'Reach \$1,000 in donations',
        isUnlocked: true,
        icon: '⭐',
        requiredAmount: 1000.0,
      ),
      const Reward(
        id: '3',
        title: 'Top Performer',
        description: 'Reach \$10,000 in donations',
        isUnlocked: true,
        icon: '🏆',
        requiredAmount: 10000.0,
      ),
      const Reward(
        id: '4',
        title: 'Champion',
        description: 'Reach \$25,000 in donations',
        isUnlocked: false,
        icon: '👑',
        requiredAmount: 25000.0,
      ),
      const Reward(
        id: '5',
        title: 'Legend',
        description: 'Reach \$50,000 in donations',
        isUnlocked: false,
        icon: '🌟',
        requiredAmount: 50000.0,
      ),
    ];
  }

  // Mock leaderboard data
  static List<LeaderboardEntry> getLeaderboard() {
    return [
      const LeaderboardEntry(
        id: '1',
        name: 'Alex Rodriguez',
        donations: 28500.00,
        rank: 1,
        referrals: 45,
      ),
      const LeaderboardEntry(
        id: '2',
        name: 'Emma Chen',
        donations: 22300.00,
        rank: 2,
        referrals: 38,
      ),
      const LeaderboardEntry(
        id: '3',
        name: 'Michael Thompson',
        donations: 19800.00,
        rank: 3,
        referrals: 31,
      ),
      const LeaderboardEntry(
        id: _currentInternId,
        name: 'Sarah Johnson',
        donations: 15750.00,
        rank: 4,
        referrals: 23,
      ),
      const LeaderboardEntry(
        id: '5',
        name: 'David Kim',
        donations: 14200.00,
        rank: 5,
        referrals: 28,
      ),
      const LeaderboardEntry(
        id: '6',
        name: 'Jessica Martinez',
        donations: 12900.00,
        rank: 6,
        referrals: 20,
      ),
      const LeaderboardEntry(
        id: '7',
        name: 'Ryan Foster',
        donations: 11500.00,
        rank: 7,
        referrals: 19,
      ),
      const LeaderboardEntry(
        id: '8',
        name: 'Lisa Wang',
        donations: 10800.00,
        rank: 8,
        referrals: 17,
      ),
      const LeaderboardEntry(
        id: '9',
        name: 'James Wilson',
        donations: 9600.00,
        rank: 9,
        referrals: 15,
      ),
      const LeaderboardEntry(
        id: '10',
        name: 'Amanda Davis',
        donations: 8900.00,
        rank: 10,
        referrals: 14,
      ),
    ];
  }

  // Mock announcements data
  static List<Announcement> getAnnouncements() {
    final now = DateTime.now();
    return [
      Announcement(
        id: '1',
        title: '🎉 Q4 Campaign Launch!',
        content:
            'We\'re excited to announce the launch of our Q4 fundraising campaign! This quarter, we\'re focusing on education initiatives and have set an ambitious goal of raising \$500,000. As our top-performing interns, you\'ll have access to exclusive resources, training materials, and bonus incentives. The campaign runs from October 1st through December 31st, with weekly check-ins and monthly recognition ceremonies. Top performers will be eligible for the annual InternRaise Excellence Awards and scholarship opportunities.',
        date: now.subtract(const Duration(hours: 2)),
        type: 'Campaign',
        isImportant: true,
      ),
      Announcement(
        id: '2',
        title: '📊 New Dashboard Features',
        content:
            'Check out the latest updates to your dashboard! We\'ve added real-time donation tracking, enhanced analytics with donation trend graphs, and a new referral management system. You can now see detailed breakdowns of your performance metrics, track your progress toward rewards, and manage your referral network more effectively. The new features also include push notifications for important updates and a streamlined reporting system.',
        date: now.subtract(const Duration(days: 1)),
        type: 'Update',
        isImportant: false,
      ),
      Announcement(
        id: '3',
        title: '🏆 Leaderboard Reset',
        content:
            'Monthly leaderboard has been reset! This is your chance to climb to the top and earn recognition as this month\'s top performer. Remember, the top 3 interns will receive special recognition, bonus rewards, and will be featured in our monthly newsletter. The competition is fierce, but we know you have what it takes to make it to the podium. Good luck to everyone!',
        date: now.subtract(const Duration(days: 2)),
        type: 'Competition',
        isImportant: false,
      ),
      Announcement(
        id: '4',
        title: '🎓 Training Session Reminder',
        content:
            'Don\'t forget about tomorrow\'s virtual training session on "Advanced Donor Engagement Strategies" at 3:00 PM EST. This session will cover proven techniques for building lasting relationships with donors, effective communication strategies, and how to leverage social media for fundraising success. The session will be recorded for those who cannot attend live, but we encourage everyone to participate in the interactive Q&A portion.',
        date: now.subtract(const Duration(days: 3)),
        type: 'Training',
        isImportant: true,
      ),
      Announcement(
        id: '5',
        title: '💰 Bonus Incentive Program',
        content:
            'Exciting news! We\'re launching a special bonus incentive program for the next two weeks. Any intern who brings in donations totaling \$5,000 or more will receive a 10% bonus on top of their regular commission. Additionally, successful referrals during this period will earn double points toward your reward tier progression. This is a fantastic opportunity to boost your earnings and advance toward those coveted reward milestones.',
        date: now.subtract(const Duration(days: 5)),
        type: 'Incentive',
        isImportant: true,
      ),
      Announcement(
        id: '6',
        title: '📱 Mobile App Update',
        content:
            'Version 2.1 of the InternRaise mobile app is now available! This update includes improved performance, bug fixes, and several new features requested by our intern community. The app now supports offline mode for viewing your dashboard, enhanced security features, and a redesigned user interface that\'s more intuitive and visually appealing. Update now to enjoy the improved experience!',
        date: now.subtract(const Duration(days: 7)),
        type: 'Update',
        isImportant: false,
      ),
    ];
  }

  // Simulate API delay
  static Future<T> _simulateDelay<T>(T data, {int milliseconds = 1000}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    return data;
  }

  // Async methods for realistic API simulation
  static Future<Intern> fetchCurrentIntern() {
    return _simulateDelay(getCurrentIntern());
  }

  static Future<List<LeaderboardEntry>> fetchLeaderboard() {
    return _simulateDelay(getLeaderboard());
  }

  static Future<List<Announcement>> fetchAnnouncements() {
    return _simulateDelay(getAnnouncements());
  }

  // Simulate login
  static Future<bool> authenticateUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    // Simple mock authentication
    return email.isNotEmpty && password.length >= 6;
  }
}

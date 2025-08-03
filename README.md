# InternRaise - Fundraising Intern Dashboard

A beautiful and modern Flutter mobile app for fundraising interns to track their donations, performance metrics, and engage with the community through leaderboards and announcements.

## 🌟 Features

### 📱 Core Functionality
- **Animated Login Screen** - Stunning gradient background with smooth animations
- **Dashboard Overview** - Real-time stats, referral codes, and reward tracking
- **Interactive Leaderboard** - Podium display with rankings and performance metrics
- **Announcements Feed** - Categorized news with detailed modal views
- **Bottom Navigation** - Smooth transitions between main screens

### 🎨 Design & UI
- **Material Design 3** - Modern, clean aesthetic with custom color scheme
- **Google Fonts (Poppins)** - Beautiful typography throughout the app
- **Custom Animations** - Smooth transitions and micro-interactions
- **Responsive Design** - Optimized for different screen sizes
- **Gradient Backgrounds** - Eye-catching visual elements
- **Card-based Layout** - Clean, organized information presentation

### 🏗️ Architecture
- **BLoC Pattern** - Robust state management with flutter_bloc
- **Separation of Concerns** - Clean architecture with proper layering
- **Mock Data Service** - Realistic API simulation for development
- **Error Handling** - Comprehensive error states and user feedback
- **Loading States** - Smooth loading indicators and skeleton screens

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK 3.0+
- IDE: VS Code, Android Studio, or IntelliJ IDEA

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd fundraising_intern_portal
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Demo Credentials
For testing the app, use these credentials:
- **Email**: any@email.com
- **Password**: 123456 (minimum 6 characters)

## 📂 Project Structure

```
lib/
├── bloc/                          # BLoC State Management
│   ├── auth/                      # Authentication logic
│   ├── dashboard/                 # Dashboard functionality
│   ├── leaderboard/              # Leaderboard management
│   └── announcements/            # Announcements handling
├── models/                        # Data Models
│   ├── intern.dart               # Intern profile model
│   ├── leaderboard_entry.dart    # Leaderboard entry model
│   └── announcement.dart         # Announcement model
├── screens/                       # UI Screens
│   ├── login_screen.dart         # Authentication screen
│   ├── dashboard_screen.dart     # Main dashboard
│   ├── leaderboard_screen.dart   # Rankings and competition
│   ├── announcements_screen.dart # News and updates
│   └── main_navigation_screen.dart # Bottom navigation
├── services/                      # Data Services
│   └── mock_data_service.dart    # Mock API simulation
├── theme/                         # App Theming
│   └── app_theme.dart           # Colors, fonts, styles
├── widgets/                       # Reusable Components
│   ├── animated_gradient_background.dart
│   ├── loading_button.dart
│   ├── stats_card.dart
│   ├── referral_code_card.dart
│   ├── rewards_section.dart
│   ├── custom_app_bar.dart
│   ├── podium_widget.dart
│   ├── leaderboard_item.dart
│   ├── announcement_card.dart
│   └── announcement_detail_modal.dart
└── main.dart                      # App entry point
```

## 🎯 Key Components

### Authentication System
- **BLoC-based Authentication** - Login/logout flow management
- **Form Validation** - Email and password validation
- **Animated UI** - Smooth login experience with gradient background
- **Error Handling** - User-friendly error messages

### Dashboard Features
- **Performance Metrics** - Total donations, referrals, monthly stats
- **Referral Code Management** - Copy-to-clipboard functionality
- **Rewards System** - Progress tracking and achievement display
- **Pull-to-refresh** - Data synchronization

### Leaderboard System
- **Interactive Podium** - Top 3 performers with animated display
- **Full Rankings** - Complete list with user highlighting
- **Performance Indicators** - Donation amounts and growth metrics
- **Real-time Updates** - Refresh capabilities

### Announcements Feed
- **Categorized Content** - Campaign, Update, Training, Incentive types
- **Priority Handling** - Important announcements highlighting
- **Detailed Modal Views** - Full content display with actions
- **Time-based Sorting** - Recent announcements first

## 🎨 Design System

### Color Palette
- **Primary**: #667eea (Blue)
- **Secondary**: #764ba2 (Purple)
- **Success**: #48BB78 (Green)
- **Warning**: #ED8936 (Orange)
- **Error**: #E53E3E (Red)
- **Background**: #F8F9FF (Light Blue)

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Weights**: Regular (400), Medium (500), Semi-Bold (600), Bold (700)
- **Sizes**: 12px - 32px with consistent scale

### Spacing System
- **XS**: 4px
- **SM**: 8px
- **MD**: 16px
- **LG**: 24px
- **XL**: 32px
- **XXL**: 48px

## 📱 Screens Overview

### 1. Login Screen
- Animated gradient background
- Form validation
- Loading states
- Demo credentials display

### 2. Dashboard
- Stats cards with animations
- Referral code sharing
- Rewards progress
- Quick actions

### 3. Leaderboard
- Podium for top 3 performers
- Full rankings list
- User position highlighting
- Performance metrics

### 4. Announcements
- Categorized news feed
- Important notices
- Detailed modal views
- Time-based organization

## 🔧 State Management

The app uses **BLoC (Business Logic Component)** pattern for state management:

- **Events**: User actions and system events
- **States**: Application state representations
- **BLoCs**: Business logic processors
- **UI**: Reactive interface components

### BLoC Structure
```dart
// Event → BLoC → State → UI
UserAction → Business Logic → New State → UI Update
```

## 🧪 Mock Data

The app includes comprehensive mock data for:
- **Intern Profiles** - Realistic user information
- **Leaderboard Entries** - Performance rankings
- **Announcements** - Various content types
- **Rewards System** - Achievement tracking

## 🚀 Future Enhancements

### Planned Features
- [ ] Push Notifications
- [ ] Offline Data Caching
- [ ] Social Media Integration
- [ ] Advanced Analytics
- [ ] Team Collaboration Tools
- [ ] Goal Setting & Tracking
- [ ] Mentor Communication System

### Technical Improvements
- [ ] Unit & Integration Tests
- [ ] Performance Optimization
- [ ] Accessibility Features
- [ ] Internationalization (i18n)
- [ ] Dark Mode Support
- [ ] Tablet Responsive Design

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Built with ❤️ using Flutter & BLoC**

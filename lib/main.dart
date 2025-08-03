import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:fundraising_intern_portal/screens/leaderboard_screen.dart';
import 'package:fundraising_intern_portal/theme/app_theme.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/dashboard/dashboard_bloc.dart';
import 'bloc/leaderboard/leaderboard_bloc.dart';
import 'bloc/announcements/announcements_bloc.dart';
import 'bloc/theme/theme_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'utils/responsive_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const InternRaiseApp()); // Remove DevicePreview wrapper
}

class InternRaiseApp extends StatelessWidget {
  const InternRaiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(const AuthCheckRequested()),
        ),
        BlocProvider<DashboardBloc>(create: (context) => DashboardBloc()),
        BlocProvider<LeaderboardBloc>(create: (context) => LeaderboardBloc()),
        BlocProvider<AnnouncementsBloc>(
          create: (context) => AnnouncementsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'InternRaise',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // Remove: useInheritedMediaQuery, locale, builder for DevicePreview
        home: const AppRouter(),
      ),
    );
  }
}

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthInitial) {
          return const SplashScreen();
        }

        if (state is AuthAuthenticated) {
          return const MainNavigationScreen();
        }

        return const LoginScreen();
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
  }

  void _startAnimations() {
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallDevice = screenSize.width < 360;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: ResponsiveUtils.responsiveConstraints(context),
              child: Padding(
                padding: AppTheme.responsivePadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _logoAnimation,
                      child: Container(
                        width: ResponsiveUtils.responsiveValue(
                          context,
                          mobile: isSmallDevice ? 100 : 120,
                          tablet: 140,
                          desktop: 160,
                        ),
                        height: ResponsiveUtils.responsiveValue(
                          context,
                          mobile: isSmallDevice ? 100 : 120,
                          tablet: 140,
                          desktop: 160,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: ResponsiveUtils.responsiveValue(
                                context,
                                mobile: 15,
                                tablet: 20,
                                desktop: 25,
                              ),
                              offset: Offset(
                                0,
                                ResponsiveUtils.responsiveValue(
                                  context,
                                  mobile: 8,
                                  tablet: 10,
                                  desktop: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.trending_up,
                          size: ResponsiveUtils.responsiveIconSize(
                            context,
                            mobile: isSmallDevice ? 50 : 60,
                            tablet: 70,
                            desktop: 80,
                          ),
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.responsiveSpacingXL(context)),
                    FadeTransition(
                      opacity: _textAnimation,
                      child: Column(
                        children: [
                          Text(
                            'InternRaise',
                            style: AppTheme.responsiveHeadingLarge(
                              context,
                            ).copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: AppTheme.responsiveSpacingSM(context),
                          ),
                          Text(
                            'Fundraising Dashboard',
                            style: AppTheme.responsiveBodyLarge(
                              context,
                            ).copyWith(color: Colors.white.withOpacity(0.9)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppTheme.responsiveSpacingXXL(context)),
                    FadeTransition(
                      opacity: _textAnimation,
                      child: SizedBox(
                        width: ResponsiveUtils.responsiveValue(
                          context,
                          mobile: 24,
                          tablet: 28,
                          desktop: 32,
                        ),
                        height: ResponsiveUtils.responsiveValue(
                          context,
                          mobile: 24,
                          tablet: 28,
                          desktop: 32,
                        ),
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

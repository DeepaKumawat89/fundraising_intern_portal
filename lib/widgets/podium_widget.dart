// import 'package:flutter/material.dart';
// import '../models/leaderboard_entry.dart';
// import '../theme/app_theme.dart';
//
// class PodiumWidget extends StatefulWidget {
//   final List<LeaderboardEntry> topThree;
//
//   const PodiumWidget({super.key, required this.topThree});
//
//   @override
//   State<PodiumWidget> createState() => _PodiumWidgetState();
// }
//
// class _PodiumWidgetState extends State<PodiumWidget>
//     with TickerProviderStateMixin {
//   late List<AnimationController> _controllers;
//   late List<Animation<double>> _animations;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//   }
//
//   void _initializeAnimations() {
//     _controllers = List.generate(
//       3,
//       (index) => AnimationController(
//         duration: Duration(milliseconds: 800 + (index * 200)),
//         vsync: this,
//       ),
//     );
//
//     _animations = _controllers.map((controller) {
//       return Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
//     }).toList();
//
//     // Start animations with delays
//     for (int i = 0; i < _controllers.length; i++) {
//       Future.delayed(Duration(milliseconds: i * 200), () {
//         if (mounted) {
//           _controllers[i].forward();
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     for (final controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.topThree.length < 3) {
//       return const SizedBox.shrink();
//     }
//
//     return SizedBox(
//       height: 300,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Flexible(child: _buildPodiumPosition(widget.topThree[1], 2, 120)), // 2nd place
//           Flexible(child: _buildPodiumPosition(widget.topThree[0], 1, 160)), // 1st place
//           Flexible(child: _buildPodiumPosition(widget.topThree[2], 3, 100)), // 3rd place
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPodiumPosition(
//     LeaderboardEntry entry,
//     int position,
//     double height,
//   ) {
//     final colors = {
//       1: AppTheme.warningColor,
//       2: const Color(0xFFC0C0C0),
//       3: const Color(0xFFCD7F32),
//     };
//
//     final icons = {1: '🥇', 2: '🥈', 3: '🥉'};
//
//     return AnimatedBuilder(
//       animation: _animations[position - 1],
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _animations[position - 1].value,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               // Profile and info
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: colors[position]!.withOpacity(0.1),
//                   border: Border.all(color: colors[position]!, width: 2),
//                 ),
//                 child: Center(
//                   child: Text(
//                     icons[position]!,
//                     style: const TextStyle(fontSize: 24),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: AppTheme.spacingSM),
//               Text(
//                 entry.name.split(' ').first,
//                 style: AppTheme.bodyMedium.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: AppTheme.spacingXS),
//               Text(
//                 '\$${entry.donations.toStringAsFixed(0)}',
//                 style: AppTheme.bodySmall.copyWith(
//                   color: colors[position]!,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: AppTheme.spacingSM),
//               // Podium base
//               Container(
//                 width: 80,
//                 height: height * _animations[position - 1].value,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       colors[position]!.withOpacity(0.8),
//                       colors[position]!,
//                     ],
//                   ),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8),
//                     topRight: Radius.circular(8),
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     '#$position',
//                     style: AppTheme.headingMedium.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/leaderboard_entry.dart';
import '../theme/app_theme.dart';

class PodiumWidget extends StatefulWidget {
  final List<LeaderboardEntry> topThree;

  const PodiumWidget({super.key, required this.topThree});

  @override
  State<PodiumWidget> createState() => _PodiumWidgetState();
}

class _PodiumWidgetState extends State<PodiumWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      3,
          (index) => AnimationController(
        duration: Duration(milliseconds: 800 + (index * 200)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();

    // Start animations with delays
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.topThree.length < 3) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 310,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(child: _buildPodiumPosition(widget.topThree[1], 2, 110)), // 2nd place
          Flexible(child: _buildPodiumPosition(widget.topThree[0], 1, 150)), // 1st place
          Flexible(child: _buildPodiumPosition(widget.topThree[2], 3, 90)), // 3rd place
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(
      LeaderboardEntry entry,
      int position,
      double height,
      ) {
    final colors = {
      1: AppTheme.warningColor,
      2: const Color(0xFFC0C0C0),
      3: const Color(0xFFCD7F32),
    };

    final icons = {1: '🥇', 2: '🥈', 3: '🥉'};

    // Truncate name to 10 characters with ellipsis if longer
    String displayName = entry.name.length > 10
        ? entry.name.substring(0, 10) + '...'
        : entry.name;

    return AnimatedBuilder(
      animation: _animations[position - 1],
      builder: (context, child) {
        return Transform.scale(
          scale: _animations[position - 1].value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Profile and info
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors[position]!.withOpacity(0.1),
                  border: Border.all(color: colors[position]!, width: 2),
                ),
                child: Center(
                  child: Text(
                    icons[position]!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                displayName,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingXS),
              Text(
                '\$${entry.donations.toStringAsFixed(0)}',
                style: AppTheme.bodySmall.copyWith(
                  color: colors[position]!,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              // Podium base
              Container(
                width: 80,
                height: height * _animations[position - 1].value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors[position]!.withOpacity(0.8),
                      colors[position]!,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    '#$position',
                    style: AppTheme.headingMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

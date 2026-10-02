import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String studentId;
  final bool hasNotification;
  final VoidCallback? onNotificationTap;

  const HomeHeader({
    super.key,
    required this.name,
    required this.studentId,
    this.hasNotification = true,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryLightColor,
            border: Border.all(color: AppTheme.primaryColor, width: 1.5),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppTheme.primaryColor,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Xin chào,',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.secondaryTextColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              if (studentId.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  'Mã SV: $studentId',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        GestureDetector(
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                size: 28,
                color: AppTheme.textColor,
              ),
              if (hasNotification)
                Positioned(
                  right: 2,
                  top: 0,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

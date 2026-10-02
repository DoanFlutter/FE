import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Row(
            children: [
              Text(
                'Xem tất cả',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: AppTheme.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

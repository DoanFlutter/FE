import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/activity_model.dart';
import '../../models/user_model.dart';
import '../../services/activities/activity_service.dart';
import '../../services/auth/auth_service.dart';
import '../../themes/app_theme.dart';
import '../../widgets/common/activity_card.dart';
import '../../widgets/home/home_banner.dart';
import '../../widgets/home/home_header.dart';
import '../../widgets/home/section_header.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Activity> _activities = [];
  UserModel? _user;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadActivities();
  }

  Future<void> _loadUser() async {
    final user = await AuthService().getUser();
    if (!mounted) return;
    setState(() => _user = user);
  }

  Future<void> _loadActivities() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await ActivityService.getOngoingActivities();
      if (!mounted) return;
      setState(() => _activities = data);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Không thể tải hoạt động. Vui lòng thử lại.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Đăng xuất', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await AuthService().logout();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadActivities,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: HomeHeader(
                          name: _user?.fullName ?? '',
                          studentId: _user?.studentCode ?? '',
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _logout,
                        tooltip: 'Đăng xuất',
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HomeBanner(),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeader(
                    title: 'Hoạt động đang diễn ra',
                    onSeeAll: () {},
                  ),
                ),
                const SizedBox(height: 12),
                _buildOngoingList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOngoingList() {
    if (_isLoading) {
      return const SizedBox(
        height: 330,
        child: Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor),
        ),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: 330,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _error!,
                style: const TextStyle(color: AppTheme.secondaryTextColor),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _loadActivities,
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_activities.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(
          child: Text(
            'Hiện chưa có hoạt động nào đang diễn ra',
            style: TextStyle(color: AppTheme.secondaryTextColor),
          ),
        ),
      );
    }

    return SizedBox(
      height: 330,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: _activities.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final activity = _activities[index];
            return ActivityCard(
              activity: activity,
              onTap: () {},
              onRegister: () {},
            );
          },
        ),
      ),
    );
  }
}

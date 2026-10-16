import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

import '../../models/activity_model.dart';

class ActivityDetailScreen extends StatelessWidget {
  final Activity activity;

  const ActivityDetailScreen({super.key, required this.activity});

  static const primaryColor = Color(0xFF1764C0);

  String formatDateTime(DateTime date) {
    String two(int value) => value.toString().padLeft(2, '0');

    return '${two(date.hour)}:${two(date.minute)} - '
        '${two(date.day)}/${two(date.month)}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isRegistered = activity.registered;
    final canRegister = activity.canRegister;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Chi tiết hoạt động',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              activity.imageUrl,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 240,
                color: const Color(0xFFE5EDF8),
                child: const Center(
                  child: Icon(Icons.image_outlined, size: 60),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTag(
                        activity.categoryName,
                        const Color(0xFFE8F1FF),
                        primaryColor,
                      ),
                      const SizedBox(width: 8),
                      _buildTag(
                        activity.statusText,
                        activity.status == 'ongoing'
                            ? const Color(0xFFE7F7EE)
                            : const Color(0xFFF1F2F4),
                        activity.status == 'ongoing'
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 24,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    activity.description,
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin hoạt động',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildInfo(
                    Icons.calendar_today_outlined,
                    'Thời gian bắt đầu',
                    formatDateTime(activity.startTime),
                  ),
                  _buildInfo(
                    Icons.schedule_outlined,
                    'Thời gian kết thúc',
                    formatDateTime(activity.endTime),
                  ),
                  _buildInfo(
                    Icons.location_on_outlined,
                    'Địa điểm',
                    activity.location,
                  ),
                  _buildInfo(
                    Icons.event_available_outlined,
                    'Hạn đăng ký',
                    formatDateTime(activity.registrationDeadline),
                  ),
                  _buildInfo(
                    Icons.groups_outlined,
                    'Số lượng tham gia',
                    '${activity.registeredCount}/${activity.maxParticipants} sinh viên',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nội dung chương trình',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (activity.content.trim().isNotEmpty)
                    // Html(
                    //   data: activity.content,
                    //   style: {
                    //     'body': Style(
                    //       margin: Margins.zero,
                    //       padding: HtmlPaddings.zero,
                    //       fontSize: FontSize(14),
                    //       lineHeight: LineHeight(1.6),
                    //     ),
                    //   },
                    // )
                    Text(
                      activity.content
                          .replaceAll(RegExp(r'<[^>]*>'), ' ')
                          .replaceAll(RegExp(r'\s+'), ' ')
                          .trim(),
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF555F70),
                      ),
                    )
                  else
                    const Text(
                      'Chưa có nội dung chi tiết.',
                      style: TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEEF0F4))),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: canRegister
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Chức năng đăng ký sẽ được kết nối API sau.',
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFE8EAF0),
                disabledForegroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                isRegistered
                    ? 'Đã đăng ký'
                    : canRegister
                    ? 'Đăng ký tham gia'
                    : 'Không thể đăng ký',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F1FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

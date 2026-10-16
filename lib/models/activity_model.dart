class Activity {
  final String id;
  final String title;
  final String description;
  final String content;
  final String categoryId;
  final String categoryName;
  final String location;
  final String imageUrl;
  final String status;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime registrationDeadline;
  final int maxParticipants;
  final int registeredCount;
  final bool registered;

  const Activity({
    required this.id,
    required this.title,
    required this.description,
    this.content = '',
    this.categoryId = '',
    this.categoryName = '',
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.registrationDeadline,
    required this.maxParticipants,
    this.registeredCount = 0,
    this.registered = false,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    final category = json['category_id'];

    String categoryId = '';
    String categoryName = '';

    if (category is Map) {
      categoryId = (category['_id'] ?? '').toString();
      categoryName = (category['name'] ?? '').toString();
    } else if (category != null) {
      categoryId = category.toString();
    }

    return Activity(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      categoryId: categoryId,
      categoryName: categoryName,
      location: (json['location'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      startTime: DateTime.parse(json['start_time'].toString()).toLocal(),
      endTime: DateTime.parse(json['end_time'].toString()).toLocal(),
      registrationDeadline: DateTime.parse(
        json['registration_deadline'].toString(),
      ).toLocal(),
      maxParticipants: (json['max_participants'] as num?)?.toInt() ?? 0,
      registeredCount: (json['registered_count'] as num?)?.toInt() ?? 0,
      registered: json['is_registered'] == true,
    );
  }

  String get timeText {
    String two(int n) => n.toString().padLeft(2, '0');

    final start = '${two(startTime.hour)}:${two(startTime.minute)}';
    final end = '${two(endTime.hour)}:${two(endTime.minute)}';
    final date =
        '${two(startTime.day)}/${two(startTime.month)}/${startTime.year}';

    return '$start - $end • $date';
  }

  String get statusText {
    switch (status) {
      case 'draft':
        return 'Bản nháp';
      case 'ongoing':
        return 'Đang diễn ra';
      case 'completed':
        return 'Đã kết thúc';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  bool get canRegister {
    return status == 'ongoing' &&
        !registered &&
        DateTime.now().isBefore(registrationDeadline) &&
        registeredCount < maxParticipants;
  }
}

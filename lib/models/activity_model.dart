class Activity {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final String status;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime registrationDeadline;
  final int maxParticipants;
  final bool registered;

  const Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.registrationDeadline,
    required this.maxParticipants,
    this.registered = false,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      location: (json['location'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      startTime: DateTime.parse(json['start_time'].toString()).toLocal(),
      endTime: DateTime.parse(json['end_time'].toString()).toLocal(),
      registrationDeadline: DateTime.parse(
        json['registration_deadline'].toString(),
      ).toLocal(),
      maxParticipants: (json['max_participants'] ?? 0) as int,
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
}

class Api {
  static const String baseUrl = 'http://192.168.1.6:5000/api';
  // Auth
  static const String login = '$baseUrl/auth/login';
  // Activities
  static const String getActivityById = '$baseUrl/activities/{id}';
  static const String getActivities = '$baseUrl/activities';
}

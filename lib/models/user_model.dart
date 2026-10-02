class UserModel {
  final String id;
  final String studentCode;
  final String fullName;
  final String email;
  final String phone;
  final String role;

  const UserModel({
    required this.id,
    required this.studentCode,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      studentCode: (json['student_code'] ?? '').toString(),
      fullName: (json['full_name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'student_code': studentCode,
    'full_name': fullName,
    'email': email,
    'phone': phone,
    'role': role,
  };
}

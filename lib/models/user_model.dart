class UserModel {
  final String userId;
  final String name;
  final String email;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
  });

  // Convert from Supabase JSON
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['id'],
      name: map['name'] ?? '',
      email: map['email'],
    );
  }
}

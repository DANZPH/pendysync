class UserModel {
  final String userId;
  final String name;
  final String email;

  UserModel({required this.userId, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['auth_id'] ?? '', // Ensure 'auth_id' is used, not 'id'
      name: map['name'] ?? 'Unknown',
      email: map['email'] ?? '',
    );
  }
}

class User {
  final int idUsers;
  final String username;
  final String email;
  final String password;
  final String role;

  User({
    required this.idUsers,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  // Convert from JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUsers: json['id_users'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }

  // Convert from User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_users': idUsers,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}

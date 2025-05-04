class User {
  final int id_users;
  final String username;
  final String email;
  final String? password; // boleh null
  final String? role; // boleh null

  User({
    required this.id_users,
    required this.username,
    required this.email,
    this.password,
    this.role,
  });

  factory User.fromRow(List<dynamic> row) {
    return User(
      id_users: row[0] as int,
      username: row[1] as String,
      email: row[2] as String,
      password: row.length > 3 ? row[3] as String? : null,
      role: row.length > 4 ? row[4] as String? : null,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id_users: json['id_users'] as int,
        username: json['username'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        role: json['role'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id_users': id_users,
        'username': username,
        'email': email,
        'password': password,
        'role': role,
      };
}

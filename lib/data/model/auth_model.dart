class RolesModel {
  final int id;
  final String name;
  final String guardName;
  final DateTime createdAt;
  final DateTime updatedAt;

  RolesModel({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      guardName: json['guard_name'] ?? '',
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RolesModel> roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),

      roles: json['roles'] != null
          ? (json['roles'] as List)
                .map((role) => RolesModel.fromJson(role))
                .toList()
          : [],
    );
  }
}

class AuthModel {
  final String message;
  final UserModel user;
  final String accessToken;
  final String tokenType;

  AuthModel({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      message: json['message'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
    );
  }
}

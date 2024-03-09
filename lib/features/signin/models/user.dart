import 'dart:convert';

import '../../../shared/data/src/hive.dart';

class User extends LocalEntity {
  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime? twoFactorConfirmedAt;
  final String currentTeamId;
  final String? profilePhotoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String profilePhotoUrl;

  User(
    super.key, {
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    required this.currentTeamId,
    this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory User.mock() {
    return User(
      '1',
      id: 1,
      name: 'John Doe',
      email: 'johndoe@email.com',
      profilePhotoUrl: 'https://avatars.githubusercontent.com/u/14052859?v=4',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      currentTeamId: '1',
    );
  }

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['id'].toString(),
        id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.parse(json['email_verified_at'])
            : null,
        twoFactorConfirmedAt: json['two_factor_confirmed_at'] != null
            ? DateTime.parse(json['two_factor_confirmed_at'])
            : null,
        currentTeamId: json['current_team_id'],
        profilePhotoPath: json['profile_photo_path'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        profilePhotoUrl: json['profile_photo_url'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'two_factor_confirmed_at': twoFactorConfirmedAt?.toIso8601String(),
        'current_team_id': currentTeamId,
        'profile_photo_path': profilePhotoPath,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'profile_photo_url': profilePhotoUrl,
      };

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, twoFactorConfirmedAt: $twoFactorConfirmedAt, currentTeamId: $currentTeamId, profilePhotoPath: $profilePhotoPath, createdAt: $createdAt, updatedAt: $updatedAt, profilePhotoUrl: $profilePhotoUrl}';
  }
}

class UserResponseData {
  final String status;
  final User user;
  final Authorization authorization;

  UserResponseData({
    required this.status,
    required this.user,
    required this.authorization,
  });

  factory UserResponseData.fromRawJson(String str) =>
      UserResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponseData.fromJson(Map<String, dynamic> json) =>
      UserResponseData(
        status: json['status'],
        user: User.fromJson(json['user']),
        authorization: Authorization.fromJson(json['authorization']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'user': user.toJson(),
        'authorization': authorization.toJson(),
      };

  @override
  String toString() {
    return 'UserResponseData{status: $status, user: $user, authorization: $authorization}';
  }
}

class Authorization {
  final String token;
  final String bearer;

  Authorization({
    required this.token,
    required this.bearer,
  });

  factory Authorization.fromRawJson(String str) =>
      Authorization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        token: json['token'],
        bearer: json['bearer'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'bearer': bearer,
      };

  @override
  String toString() {
    return 'Authorization{token: $token, bearer: $bearer}';
  }
}

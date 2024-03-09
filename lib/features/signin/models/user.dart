import 'dart:convert';

// email: mail@imerzone.com
// password: P@ssw0rd

class User {
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

  User({
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

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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

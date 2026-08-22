// class LoginRequest {
//   final String email;
//   final String password;

//   const LoginRequest({
//     required this.email,
//     required this.password,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'password': password,
//     };
//   }
// }

// class AuthSession {
//   final String accessToken;
//   final String refreshToken;
//   final String userId;
//   final String organizationId;
//   final String role;
//   final DateTime expiresAt;

//   const AuthSession({
//     required this.accessToken,
//     required this.refreshToken,
//     required this.userId,
//     required this.organizationId,
//     required this.role,
//     required this.expiresAt,
//   });

//   bool get isExpired {
//     return DateTime.now().isAfter(expiresAt);
//   }

//   factory AuthSession.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return AuthSession(
//       accessToken:
//           json['access_token']?.toString() ?? '',
//       refreshToken:
//           json['refresh_token']?.toString() ?? '',
//       userId:
//           json['user_id']?.toString() ?? '',
//       organizationId:
//           json['organization_id']?.toString() ?? '',
//       role:
//           json['role']?.toString() ?? '',
//       expiresAt: DateTime.tryParse(
//             json['expires_at']?.toString() ?? '',
//           ) ??
//           DateTime.now(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'access_token': accessToken,
//       'refresh_token': refreshToken,
//       'user_id': userId,
//       'organization_id': organizationId,
//       'role': role,
//       'expires_at': expiresAt.toIso8601String(),
//     };
//   }
// }

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });
}

class AuthSession {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String organizationId;
  final String role;
  final DateTime expiresAt;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.organizationId,
    required this.role,
    required this.expiresAt,
  });

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  factory AuthSession.fromJson(
    Map<String, dynamic> json,
  ) {
    return AuthSession(
      accessToken:
          json['access_token']?.toString() ?? '',

      refreshToken:
          json['refresh_token']?.toString() ?? '',

      userId:
          json['user_id']?.toString() ?? '',

      organizationId:
          json['organization_id']?.toString() ?? '',

      role:
          json['role']?.toString() ?? '',

      expiresAt: DateTime.tryParse(
            json['expires_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user_id': userId,
      'organization_id': organizationId,
      'role': role,
      'expires_at':
          expiresAt.toIso8601String(),
    };
  }
}
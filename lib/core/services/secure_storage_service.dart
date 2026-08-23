// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorageService {
//   final FlutterSecureStorage _storage =
//       const FlutterSecureStorage();

//   static const _accessTokenKey = 'access_token';
//   static const _refreshTokenKey = 'refresh_token';
//   static const _userIdKey = 'user_id';
//   static const _organizationIdKey = 'organization_id';
//   static const _roleKey = 'role';
//   static const _expiresAtKey = 'expires_at';

//   Future<void> saveSession(String jsonEncode, {
//     required String accessToken,
//     required String refreshToken,
//     required String userId,
//     required String organizationId,
//     required String role,
//     required String expiresAt,
//   }) async {
//     await _storage.write(
//       key: _accessTokenKey,
//       value: accessToken,
//     );

//     await _storage.write(
//       key: _refreshTokenKey,
//       value: refreshToken,
//     );

//     await _storage.write(
//       key: _userIdKey,
//       value: userId,
//     );

//     await _storage.write(
//       key: _organizationIdKey,
//       value: organizationId,
//     );

//     await _storage.write(
//       key: _roleKey,
//       value: role,
//     );

//     await _storage.write(
//       key: _expiresAtKey,
//       value: expiresAt,
//     );
//   }

//   Future<Map<String, String?>> getSession() async {
//     return {
//       'access_token':
//           await _storage.read(key: _accessTokenKey),

//       'refresh_token':
//           await _storage.read(key: _refreshTokenKey),

//       'user_id':
//           await _storage.read(key: _userIdKey),

//       'organization_id':
//           await _storage.read(key: _organizationIdKey),

//       'role':
//           await _storage.read(key: _roleKey),

//       'expires_at':
//           await _storage.read(key: _expiresAtKey),
//     };
//   }

//   Future<bool> hasSession() async {
//     final token = await _storage.read(
//       key: _accessTokenKey,
//     );

//     return token != null && token.isNotEmpty;
//   }

//   Future<void> clearSession() async {
//     await _storage.deleteAll();
//   }
// }

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage =
      const FlutterSecureStorage();

  static const String _sessionKey =
      'auth_session';

  Future<void> saveSession(
    String session,
  ) async {
    await _storage.write(
      key: _sessionKey,
      value: session,
    );
  }

  Future<String?> getSession() async {
    return await _storage.read(
      key: _sessionKey,
    );
  }

  Future<void> clearSession() async {
    await _storage.delete(
      key: _sessionKey,
    );
  }
}
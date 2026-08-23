// import 'dart:math';

// import 'package:task_manager/data/datasources/mock/mock_data_source.dart';
// import 'package:task_manager/data/models/auth_models.dart';
// import 'package:task_manager/data/models/org_member_model.dart';

// import '../../core/services/secure_storage_service.dart';
// import '../../domain/repositories/auth_repository.dart';
// // import '../datasources/mock/mock_data_source.dart';
// // import '../models/auth_models.dart';
// // import '../models/org_member_model.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final MockDataSource mockDataSource;
//   final SecureStorageService secureStorage;

//   AuthRepositoryImpl({
//     required this.mockDataSource,
//     required this.secureStorage,
//   });

//   @override
//   Future<AuthSession> login({
//     required String email,
//     required String password,
//   }) async {
//     // Simulate API delay
//     await Future.delayed(
//       const Duration(seconds: 1),
//     );

//     final authData =
//         await mockDataSource.getAuthMockData();

//     final accounts =
//         List<dynamic>.from(
//       authData['accounts'] ?? [],
//     );

//     Map<String, dynamic>? matchedAccount;

//     for (final account in accounts) {
//       final accountData =
//           Map<String, dynamic>.from(account);

//       final accountEmail =
//           accountData['email']?.toString();

//       final accountPassword =
//           accountData['password']?.toString();

//       if (accountEmail == email &&
//           accountPassword == password) {
//         matchedAccount = accountData;
//         break;
//       }
//     }

//     if (matchedAccount == null) {
//       throw Exception(
//         'Invalid email or password',
//       );
//     }

//     final userId =
//         matchedAccount['user_id']?.toString() ?? '';

//     final organizationId =
//         matchedAccount['organization_id']
//                 ?.toString() ??
//             '';

//     final role =
//         await _getUserRole(
//       userId,
//       organizationId,
//     );

//     final session = AuthSession(
//       accessToken: _generateToken(),
//       refreshToken: _generateToken(),
//       userId: userId,
//       organizationId: organizationId,
//       role: role,

//       // 15 minutes
//       expiresAt: DateTime.now().add(
//         const Duration(minutes: 15),
//       ),
//     );

//     await secureStorage.saveSession(
//       accessToken: session.accessToken,
//       refreshToken: session.refreshToken,
//       userId: session.userId,
//       organizationId: session.organizationId,
//       role: session.role,
//       expiresAt:
//           session.expiresAt.toIso8601String(),
//     );

//     return session;
//   }

//   Future<String> _getUserRole(
//     String userId,
//     String organizationId,
//   ) async {
//     final members =
//         await mockDataSource.getOrgMembers();

//     OrgMemberModel? member;

//     for (final item in members) {
//       if (item.userId == userId &&
//           item.organizationId ==
//               organizationId) {
//         member = item;
//         break;
//       }
//     }

//     if (member == null) {
//       throw Exception(
//         'User is not a member of this organization',
//       );
//     }

//     return member.role;
//   }

//   @override
//   Future<AuthSession?> getCurrentSession() async {
//     final hasSession =
//         await secureStorage.hasSession();

//     if (!hasSession) {
//       return null;
//     }

//     final data =
//         await secureStorage.getSession();

//     final expiresAt =
//         DateTime.tryParse(
//       data['expires_at'] ?? '',
//     );

//     if (expiresAt == null) {
//       return null;
//     }

//     return AuthSession(
//       accessToken:
//           data['access_token'] ?? '',

//       refreshToken:
//           data['refresh_token'] ?? '',

//       userId:
//           data['user_id'] ?? '',

//       organizationId:
//           data['organization_id'] ?? '',

//       role:
//           data['role'] ?? '',

//       expiresAt: expiresAt,
//     );
//   }

//   @override
//   Future<AuthSession> refreshSession() async {
//     final currentSession =
//         await getCurrentSession();

//     if (currentSession == null) {
//       throw Exception(
//         'No session found',
//       );
//     }

//     if (currentSession.refreshToken.isEmpty) {
//       throw Exception(
//         'Refresh token not found',
//       );
//     }

//     // Simulate API call
//     await Future.delayed(
//       const Duration(seconds: 1),
//     );

//     final newSession = AuthSession(
//       accessToken: _generateToken(),
//       refreshToken:
//           currentSession.refreshToken,
//       userId: currentSession.userId,
//       organizationId:
//           currentSession.organizationId,
//       role: currentSession.role,

//       expiresAt: DateTime.now().add(
//         const Duration(minutes: 15),
//       ),
//     );

//     await secureStorage.saveSession(
//       accessToken: newSession.accessToken,
//       refreshToken: newSession.refreshToken,
//       userId: newSession.userId,
//       organizationId:
//           newSession.organizationId,
//       role: newSession.role,
//       expiresAt:
//           newSession.expiresAt
//               .toIso8601String(),
//     );

//     return newSession;
//   }

//   @override
//   Future<void> logout() async {
//     await secureStorage.clearSession();
//   }

//   String _generateToken() {
//     final random = Random();

//     final value = List.generate(
//       32,
//       (_) => random.nextInt(16).toRadixString(16),
//     ).join();

//     return value;
//   }
// }
import 'dart:convert';

import 'package:task_manager/core/services/secure_storage_service.dart';
import 'package:task_manager/data/datasources/mock/mock_data_source.dart';
import 'package:task_manager/data/models/auth_models.dart';

import '../../domain/repositories/auth_repository.dart';
// import '../datasources/local/secure_storage_service.dart';
// import '../datasources/mock/mock_data_source.dart';
// import '../models/auth_models.dart';

class AuthRepositoryImpl
    implements AuthRepository {
  final MockDataSource mockDataSource;
  final SecureStorageService secureStorage;

  AuthRepositoryImpl({
    required this.mockDataSource,
    required this.secureStorage,
  });

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      print('Repository Login Started');

      // MockDataSource se login
      final response =
          await mockDataSource.login(
        email: email.trim(),
        password: password.trim(),
      );

      print('Login Response: $response');

      final session = AuthSession.fromJson(
        response,
      );

      // Secure storage mein save
      await secureStorage.saveSession(
        jsonEncode(session.toJson()),
      );

      print('Session Saved Successfully');

      return session;
    } catch (e) {
      print('Repository Login Error: $e');

      rethrow;
    }
  }

  @override
  Future<AuthSession?>
      getCurrentSession() async {
    final sessionData =
        await secureStorage.getSession();

    if (sessionData == null ||
        sessionData.isEmpty) {
      return null;
    }

    try {
      final json =
          jsonDecode(sessionData)
              as Map<String, dynamic>;

      return AuthSession.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthSession>
      refreshSession() async {
    final session =
        await getCurrentSession();

    if (session == null) {
      throw Exception('Session not found');
    }

    final newSession = AuthSession(
      userId: session.userId,
      organizationId:
          session.organizationId,
      role: session.role,
      accessToken:
          'refreshed_mock_token_${session.userId}',
      refreshToken:
          session.refreshToken,
      expiresAt: DateTime.now().add(
        const Duration(hours: 1),
      ),
    );

    await secureStorage.saveSession(
      jsonEncode(newSession.toJson()),
    );

    return newSession;
  }

  @override
  Future<void> logout() async {
    await secureStorage.clearSession();
  }
}
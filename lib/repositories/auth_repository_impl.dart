
import 'dart:convert';

import 'package:task_manager/core/services/secure_storage_service.dart';
import 'package:task_manager/data/datasources/mock/mock_data_source.dart';
import 'package:task_manager/data/models/auth_models.dart';
import 'package:task_manager/repositories/auth_repository.dart';


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
// import '../../data/models/auth_models.dart';

// abstract class AuthRepository {
//   Future<AuthSession> login({
//     required String email,
//     required String password,
//   });

//   Future<AuthSession?> getCurrentSession();

//   Future<AuthSession> refreshSession();

//   Future<void> logout();
// }
import '../../data/models/auth_models.dart';

abstract class AuthRepository {
  Future<AuthSession> login({
    required String email,
    required String password,
  });

  Future<AuthSession?> getCurrentSession();

  Future<AuthSession> refreshSession();

  Future<void> logout();
}
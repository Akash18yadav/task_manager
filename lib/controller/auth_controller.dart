import 'package:get/get.dart';

import '../../core/enums/view_state.dart';
import '../../data/models/auth_models.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({
    required this.repository,
  });

  final state = ViewState.initial.obs;

  final errorMessage = ''.obs;

  final currentSession =
      Rxn<AuthSession>();

  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value =
        !isPasswordVisible.value;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state.value = ViewState.loading;

      errorMessage.value = '';

      final session =
          await repository.login(
        email: email.trim(),
        password: password,
      );

      currentSession.value = session;

      state.value = ViewState.success;

      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value =
          e.toString().replaceFirst(
                'Exception: ',
                '',
              );

      state.value = ViewState.error;
    }
  }

  Future<void> checkSession() async {
    try {
      state.value = ViewState.loading;

      final session =
          await repository.getCurrentSession();

      if (session == null) {
        Get.offAllNamed('/login');
        return;
      }

      currentSession.value = session;

      if (session.isExpired) {
        await refreshSession();
      } else {
        state.value = ViewState.success;

        Get.offAllNamed('/home');
      }
    } catch (e) {
      await logout(
        navigateToLogin: true,
      );
    }
  }

  Future<void> refreshSession() async {
    try {
      state.value = ViewState.loading;

      final session =
          await repository.refreshSession();

      currentSession.value = session;

      state.value = ViewState.success;

      Get.offAllNamed('/home');
    } catch (e) {
      await logout(
        navigateToLogin: true,
      );
    }
  }

  Future<void> logout({
    bool navigateToLogin = true,
  }) async {
    await repository.logout();

    currentSession.value = null;

    state.value = ViewState.initial;

    if (navigateToLogin) {
      Get.offAllNamed('/login');
    }
  }

  bool get isAdmin {
    return currentSession.value?.role ==
        'org_admin';
  }

  String get currentUserId {
    return currentSession.value?.userId ?? '';
  }

  String get currentOrganizationId {
    return currentSession.value?.organizationId ??
        '';
  }
}
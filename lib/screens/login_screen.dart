// import 'package:flutter/material.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: const Center(
//         child: Text('Login Screen'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';

import '../../../core/enums/view_state.dart';
// import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final authController =
      Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(24),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                children: [
                  const Icon(
                    Icons.task_alt_rounded,
                    size: 80,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  const Text(
                    'Welcome Back',
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    'Login to continue to TaskFlow',
                    textAlign:
                        TextAlign.center,
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  TextFormField(
                    controller:
                        _emailController,

                    keyboardType:
                        TextInputType.emailAddress,

                    decoration:
                        const InputDecoration(
                      labelText: 'Email',
                      prefixIcon:
                          Icon(Icons.email),
                    ),

                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Email is required';
                      }

                      if (!GetUtils.isEmail(
                        value.trim(),
                      )) {
                        return 'Enter valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Obx(
                    () => TextFormField(
                      controller:
                          _passwordController,

                      obscureText:
                          !authController
                              .isPasswordVisible
                              .value,

                      decoration:
                          InputDecoration(
                        labelText: 'Password',

                        prefixIcon:
                            const Icon(
                          Icons.lock,
                        ),

                        suffixIcon:
                            IconButton(
                          onPressed:
                              authController
                                  .togglePasswordVisibility,

                          icon: Icon(
                            authController
                                    .isPasswordVisible
                                    .value
                                ? Icons
                                    .visibility_off
                                : Icons
                                    .visibility,
                          ),
                        ),
                      ),

                      validator: (value) {
                        if (value == null ||
                            value.isEmpty) {
                          return 'Password is required';
                        }

                        if (value.length < 4) {
                          return 'Password must be at least 4 characters';
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Obx(() {
                    if (authController
                            .state
                            .value !=
                        ViewState.error) {
                      return const SizedBox();
                    }

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: Text(
                        authController
                            .errorMessage
                            .value,

                        style: const TextStyle(
                          color: Colors.red,
                        ),

                        textAlign:
                            TextAlign.center,
                      ),
                    );
                  }),

                  const SizedBox(
                    height: 12,
                  ),

                  Obx(() {
                    final isLoading =
                        authController
                                .state
                                .value ==
                            ViewState.loading;

                    return SizedBox(
                      height: 52,

                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : _login,

                        child: isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Login',
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
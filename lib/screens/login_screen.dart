// // import 'package:flutter/material.dart';

// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Login'),
// //       ),
// //       body: const Center(
// //         child: Text('Login Screen'),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/controller/auth_controller.dart';

// import '../../../core/enums/view_state.dart';
// // import '../../controllers/auth_controller.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() {
//     return _LoginScreenState();
//   }
// }

// class _LoginScreenState
//     extends State<LoginScreen> {
//   final _formKey =
//       GlobalKey<FormState>();

//   final _emailController =
//       TextEditingController();
     

//   final _passwordController =
//       TextEditingController();

//   final authController =
//       Get.find<AuthController>();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();

//     super.dispose();
//   }

//   void _login() {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     authController.login(
//       email: _emailController.text,
//       password: _passwordController.text,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding:
//                 const EdgeInsets.all(24),

//             child: Form(
//               key: _formKey,

//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.stretch,

//                 children: [
//                   const Icon(
//                     Icons.task_alt_rounded,
//                     size: 80,
//                   ),

//                   const SizedBox(
//                     height: 24,
//                   ),

//                   const Text(
//                     'Welcome Back',
//                     textAlign:
//                         TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 8,
//                   ),

//                   const Text(
//                     'Login to continue to TaskFlow',
//                     textAlign:
//                         TextAlign.center,
//                   ),

//                   const SizedBox(
//                     height: 40,
//                   ),

//                   TextFormField(
//                     controller:
//                         _emailController,

//                     keyboardType:
//                         TextInputType.emailAddress,

//                     decoration:
//                         const InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon:
//                           Icon(Icons.email),
//                     ),

//                     validator: (value) {
//                       if (value == null ||
//                           value.trim().isEmpty) {
//                         return 'Email is required';
//                       }

//                       if (!GetUtils.isEmail(
//                         value.trim(),
//                       )) {
//                         return 'Enter valid email';
//                       }

//                       return null;
//                     },
//                   ),

//                   const SizedBox(
//                     height: 20,
//                   ),

//                   Obx(
//                     () => TextFormField(
//                       controller:
//                           _passwordController,

//                       obscureText:
//                           !authController
//                               .isPasswordVisible
//                               .value,

//                       decoration:
//                           InputDecoration(
//                         labelText: 'Password',

//                         prefixIcon:
//                             const Icon(
//                           Icons.lock,
//                         ),

//                         suffixIcon:
//                             IconButton(
//                           onPressed:
//                               authController
//                                   .togglePasswordVisibility,

//                           icon: Icon(
//                             authController
//                                     .isPasswordVisible
//                                     .value
//                                 ? Icons
//                                     .visibility_off
//                                 : Icons
//                                     .visibility,
//                           ),
//                         ),
//                       ),

//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty) {
//                           return 'Password is required';
//                         }

//                         if (value.length < 4) {
//                           return 'Password must be at least 4 characters';
//                         }

//                         return null;
//                       },
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 12,
//                   ),

//                   Obx(() {
//                     if (authController
//                             .state
//                             .value !=
//                         ViewState.error) {
//                       return const SizedBox();
//                     }

//                     return Padding(
//                       padding:
//                           const EdgeInsets.only(
//                         bottom: 12,
//                       ),

//                       child: Text(
//                         authController
//                             .errorMessage
//                             .value,

//                         style: const TextStyle(
//                           color: Colors.red,
//                         ),

//                         textAlign:
//                             TextAlign.center,
//                       ),
//                     );
//                   }),

//                   const SizedBox(
//                     height: 12,
//                   ),

//                   Obx(() {
//                     final isLoading =
//                         authController
//                                 .state
//                                 .value ==
//                             ViewState.loading;

//                     return SizedBox(
//                       height: 52,

//                       child: ElevatedButton(
//                         onPressed:
//                             isLoading
//                                 ? null
//                                 : _login,

//                         child: isLoading
//                             ? const SizedBox(
//                                 height: 24,
//                                 width: 24,
//                                 child:
//                                     CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : const Text(
//                                 'Login',
//                               ),
//                       ),
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';

import '../../../core/enums/view_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final authController = Get.find<AuthController>();

  bool _rememberMe = true;

  // Colors according to the given UI
  static const Color _backgroundColor =
      Color(0xFF08111F);

  static const Color _fieldColor =
      Color(0xFF0B1626);

  static const Color _borderColor =
      Color(0xFF26364B);

  static const Color _primaryColor =
      Color(0xFF7856F6);

  static const Color _secondaryPurple =
      Color(0xFF9A6AFB);

  static const Color _textColor =
      Color(0xFFF4F5F7);

  static const Color _subtitleColor =
      Color(0xFF9BA6B8);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  // ================= LOGIN LOGIC =================

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
      backgroundColor: _backgroundColor,

      body: SafeArea(
        child: Stack(
          children: [
            // Bottom decorative circle
            Positioned(
              left: -80,
              bottom: -100,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _primaryColor.withOpacity(0.05),
                ),
              ),
            ),

            // Top right decorative circle
            Positioned(
              right: -60,
              top: -70,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _primaryColor.withOpacity(0.05),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 24,
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,

                    children: [
                      // ====================================
                      // TOP SECTION
                      // ====================================

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(
                                top: 20,
                              ),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [
                                  const Text(
                                    'Welcome',
                                    style: TextStyle(
                                      color: _textColor,
                                      fontSize: 27,
                                      fontWeight:
                                          FontWeight.w700,
                                      height: 1.15,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 2,
                                  ),

                                  const Text(
                                    'Back!',
                                    style: TextStyle(
                                      color: _textColor,
                                      fontSize: 27,
                                      fontWeight:
                                          FontWeight.w700,
                                      height: 1.15,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),

                                  const Text(
                                    'Sign in to continue to\nyour account',
                                    style: TextStyle(
                                      color:
                                          _subtitleColor,
                                      fontSize: 12,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Illustration
                          SizedBox(
                            width: 115,
                            height: 135,

                            child: Image.network(
                              'https://p7.hiclipart.com/preview/108/833/250/questionnaire-checklist-survey-methodology-survey.jpg',

                              fit: BoxFit.contain,

                              errorBuilder:
                                  (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Container(
                                  decoration:
                                      BoxDecoration(
                                    color: _primaryColor
                                        .withOpacity(
                                      0.12,
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      22,
                                    ),
                                  ),

                                  child: const Icon(
                                    Icons
                                        .assignment_turned_in_rounded,
                                    size: 70,
                                    color:
                                        _secondaryPurple,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 42,
                      ),

                      // ====================================
                      // EMAIL FIELD
                      // ====================================

                      _buildTextField(
                        controller:
                            _emailController,

                        hintText:
                            'Email address',

                        prefixIcon:
                            Icons
                                .person_outline_rounded,

                        keyboardType:
                            TextInputType
                                .emailAddress,

                        validator: (value) {
                          if (value == null ||
                              value
                                  .trim()
                                  .isEmpty) {
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
                        height: 14,
                      ),

                      // ====================================
                      // PASSWORD FIELD
                      // ====================================

                      Obx(
                        () => _buildTextField(
                          controller:
                              _passwordController,

                          hintText:
                              'Password',

                          prefixIcon:
                              Icons.lock_outline_rounded,

                          obscureText:
                              !authController
                                  .isPasswordVisible
                                  .value,

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
                                      .visibility_off_outlined
                                  : Icons
                                      .visibility_outlined,

                              color:
                                  _subtitleColor,

                              size: 20,
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
                        height: 8,
                      ),

                      // ====================================
                      // REMEMBER ME + FORGOT PASSWORD
                      // ====================================

                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _rememberMe =
                                    !_rememberMe;
                              });
                            },

                            borderRadius:
                                BorderRadius.circular(
                              5,
                            ),

                            child: Row(
                              children: [
                                Container(
                                  width: 17,
                                  height: 17,

                                  decoration:
                                      BoxDecoration(
                                    color: _rememberMe
                                        ? _primaryColor
                                        : Colors
                                            .transparent,

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      4,
                                    ),

                                    border: Border.all(
                                      color: _rememberMe
                                          ? _primaryColor
                                          : _subtitleColor,
                                    ),
                                  ),

                                  child: _rememberMe
                                      ? const Icon(
                                          Icons.check,
                                          size: 13,
                                          color:
                                              Colors.white,
                                        )
                                      : null,
                                ),

                                const SizedBox(
                                  width: 7,
                                ),

                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color:
                                        _subtitleColor,
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          TextButton(
                            onPressed: () {
                              // Future forgot password logic
                            },

                            style:
                                TextButton.styleFrom(
                              padding:
                                  EdgeInsets.zero,

                              minimumSize:
                                  const Size(0, 30),

                              tapTargetSize:
                                  MaterialTapTargetSize
                                      .shrinkWrap,
                            ),

                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color:
                                    _secondaryPurple,
                                fontSize: 10,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // ====================================
                      // ERROR MESSAGE
                      // ====================================

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
                                .errorMessage.value,

                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                            ),

                            textAlign:
                                TextAlign.center,
                          ),
                        );
                      }),

                      // ====================================
                      // LOGIN BUTTON
                      // ====================================

                      Obx(() {
                        final isLoading =
                            authController
                                    .state
                                    .value ==
                                ViewState.loading;

                        return SizedBox(
                          height: 55,

                          child: DecoratedBox(
                            decoration:
                                BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),

                              gradient:
                                  const LinearGradient(
                                colors: [
                                  _primaryColor,
                                  _secondaryPurple,
                                ],
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: _primaryColor
                                      .withOpacity(
                                    0.25,
                                  ),
                                  blurRadius: 15,
                                  offset:
                                      const Offset(
                                    0,
                                    6,
                                  ),
                                ),
                              ],
                            ),

                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : _login,

                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    Colors.transparent,

                                disabledBackgroundColor:
                                    Colors.transparent,

                                shadowColor:
                                    Colors.transparent,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    12,
                                  ),
                                ),
                              ),

                              child: isLoading
                                  ? const SizedBox(
                                      height: 23,
                                      width: 23,

                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth:
                                            2,

                                        color:
                                            Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Sign In',

                                      style: TextStyle(
                                        color:
                                            Colors.white,

                                        fontSize: 14,

                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(
                        height: 22,
                      ),

                      // ====================================
                      // OR DIVIDER
                      // ====================================

                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: _borderColor,
                              thickness: 1,
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),

                            child: Text(
                              'or',

                              style: TextStyle(
                                color: _subtitleColor
                                    .withOpacity(
                                  0.9,
                                ),

                                fontSize: 11,
                              ),
                            ),
                          ),

                          const Expanded(
                            child: Divider(
                              color: _borderColor,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      // ====================================
                      // GOOGLE BUTTON
                      // ====================================

                      _buildSocialButton(
                        icon: const Text(
                          'G',

                          style: TextStyle(
                            fontSize: 21,
                            fontWeight:
                                FontWeight.bold,
                            color: Color(
                              0xFF4285F4,
                            ),
                          ),
                        ),

                        text:
                            'Continue with Google',

                        onTap: () {
                          // Future Google login
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // ====================================
                      // APPLE BUTTON
                      // ====================================

                      _buildSocialButton(
                        icon: const Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: 22,
                        ),

                        text:
                            'Continue with Apple',

                        onTap: () {
                          // Future Apple login
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // ====================================
                      // MICROSOFT BUTTON
                      // ====================================

                      _buildSocialButton(
                        icon: const Icon(
                          Icons
                              .window_rounded,
                          color: Color(
                            0xFF00A4EF,
                          ),
                          size: 20,
                        ),

                        text:
                            'Continue with Microsoft',

                        onTap: () {
                          // Future Microsoft login
                        },
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // ====================================
                      // SIGN UP
                      // ====================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          const Text(
                            "Don't have an account? ",

                            style: TextStyle(
                              color:
                                  _subtitleColor,

                              fontSize: 11,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              // Future signup navigation
                            },

                            child: const Text(
                              'Sign up',

                              style: TextStyle(
                                color:
                                    _secondaryPurple,

                                fontSize: 11,

                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====================================
  // CUSTOM TEXT FIELD
  // ====================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,

      obscureText: obscureText,

      style: const TextStyle(
        color: _textColor,
        fontSize: 12,
      ),

      cursorColor: _secondaryPurple,

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: const TextStyle(
          color: _subtitleColor,
          fontSize: 11,
        ),

        prefixIcon: Icon(
          prefixIcon,
          color: _subtitleColor,
          size: 19,
        ),

        suffixIcon: suffixIcon,

        filled: true,

        fillColor: _fieldColor,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            11,
          ),

          borderSide: const BorderSide(
            color: _borderColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            11,
          ),

          borderSide: const BorderSide(
            color: _primaryColor,
            width: 1.3,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            11,
          ),

          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),

        focusedErrorBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            11,
          ),

          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.3,
          ),
        ),
      ),

      validator: validator,
    );
  }

  // ====================================
  // SOCIAL LOGIN BUTTON
  // ====================================

  Widget _buildSocialButton({
    required Widget icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 48,

      child: OutlinedButton(
        onPressed: onTap,

        style: OutlinedButton.styleFrom(
          backgroundColor:
              const Color(0xFF111E2F),

          side: const BorderSide(
            color: Color(0xFF1E2C3D),
          ),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              10,
            ),
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            SizedBox(
              width: 24,
              child: Center(
                child: icon,
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            Text(
              text,

              style: const TextStyle(
                color: Color(0xFFE5E7EB),

                fontSize: 11,

                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
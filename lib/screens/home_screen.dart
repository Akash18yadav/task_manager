

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/screens/projects/project_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFF050918),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: const Text(
          'TaskFlow',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: Obx(() {
        final session =
            authController.currentSession.value;

        if (session == null) {
          return const Center(
            child: Text(
              'No active session',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: double.infinity,

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF050918),
                Color(0xFF080A20),
                Color(0xFF050918),
              ],
            ),
          ),

          child: SafeArea(
            top: false,

            child: SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),

              padding: const EdgeInsets.fromLTRB(
                32,
                15,
                32,
                30,
              ),

              child: Column(
                children: [

                  // DECORATIVE PURPLE BACKGROUND

                  Stack(
                    alignment: Alignment.center,

                    children: [

                      Positioned(
                        top: 20,
                        child: Container(
                          width: 220,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(
                              0xFF392070,
                            ).withOpacity(0.20),
                          ),
                        ),
                      ),

                      // PROFILE AVATAR

                      Container(
                        width: 108,
                        height: 108,

                        padding:
                            const EdgeInsets.all(5),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(0xFF8B5CF6),
                              Color(0xFF312E81),
                            ],
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF7C3AED,
                              ).withOpacity(0.35),
                              blurRadius: 25,
                              spreadRadius: 4,
                            ),
                          ],
                        ),

                        child: Container(
                          decoration:
                              const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE8E8E8),
                          ),

                          padding:
                              const EdgeInsets.all(3),

                          child: ClipOval(
                            child: Image.network(
                              'https://i.pravatar.cc/300?img=12',

                              fit: BoxFit.cover,

                              errorBuilder:
                                  (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                return const Icon(
                                  Icons.person,
                                  size: 65,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // WELCOME TEXT

                  const Text(
                    'Welcome back,',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    '${session.role == 'org_admin' ? 'Admin' : 'Member'} 👋',

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Color(0xFFB85CFF),
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // USER INFORMATION CARD

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFF101326),

                      borderRadius:
                          BorderRadius.circular(16),

                      border: Border.all(
                        color: const Color(
                          0xFF292C48,
                        ),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.25),
                          blurRadius: 15,
                          offset:
                              const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [

                        _infoRow(
                          icon:
                              Icons.person_outline_rounded,
                          title: 'User ID',
                          value: session.userId,
                        ),

                        _divider(),

                        _infoRow(
                          icon:
                              Icons.business_outlined,
                          title: 'Organization ID',
                          value:
                              session.organizationId,
                        ),

                        _divider(),

                        _infoRow(
                          icon:
                              Icons
                                  .admin_panel_settings_outlined,
                          title: 'Role',
                          value: session.role,
                        ),

                        // Token expiry intentionally
                        // not displayed on UI.
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // PROJECT + TASK BUTTONS

                  Row(
                    children: [

                      // VIEW PROJECTS

                      Expanded(
                        child: _dashboardButton(
                          icon:
                              Icons.folder_rounded,

                          title:
                              'View Projects',

                          onTap: () {
                            Get.toNamed(
                              '/projects',
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const ProjectListScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 14),

                   
                      // TASK
                   

                      Expanded(
                        child: _dashboardButton(
                          icon:
                              Icons
                                  .assignment_rounded,

                          title: 'Task',

                          onTap: () {
                            Get.toNamed(
                              '/tasks',
                              arguments:
                                  'proj_1001',
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

             
                  // LOGOUT BUTTON
                

                  _logoutButton(
                    onTap: () {
                      authController.logout();
                    },
                  ),

                  const SizedBox(height: 45),

             
                  // DECORATIVE DOTS
             

                  Align(
                    alignment:
                        Alignment.bottomRight,

                    child: SizedBox(
                      width: 80,
                      height: 45,

                      child: Wrap(
                        spacing: 8,
                        runSpacing: 7,

                        children: List.generate(
                          18,
                          (index) {
                            return Container(
                              width: 3,
                              height: 3,

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFF6D28D9,
                                ).withOpacity(
                                  0.25 +
                                      (index %
                                              3) *
                                          0.15,
                                ),

                                shape:
                                    BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }


  // INFO ROW


  static Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 11,
      ),

      child: Row(
        children: [

          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color: const Color(
                0xFF6D28D9,
              ).withOpacity(0.10),

              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              color: const Color(
                0xFFB56CFF,
              ),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color: Color(0xFF9B9EB0),
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,

                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DIVIDER
 
  static Widget _divider() {
    return Container(
      height: 1,
      color: const Color(0xFF24273B),
    );
  }

  // PROJECT / TASK BUTTON

  static Widget _dashboardButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),

      onTap: onTap,

      child: Container(
        height: 158,

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xFF7846E8),
              Color(0xFF3930B8),
            ],
          ),

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF5B21B6,
              ).withOpacity(0.25),

              blurRadius: 15,
              offset:
                  const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // ICON
            Container(
              width: 54,
              height: 54,

              decoration:
                  const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color:
                    const Color(0xFF6941C6),
                size: 30,
              ),
            ),

            const SizedBox(height: 13),

            Text(
              title,

              textAlign:
                  TextAlign.center,

              maxLines: 2,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            // ARROW
            Container(
              width: 34,
              height: 34,

              decoration:
                  const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.arrow_forward_rounded,
                color:
                    Color(0xFF6040C7),
                size: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // LOGOUT BUTTON
  // ===============================================================

  static Widget _logoutButton({
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(17),

      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: 68,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 22,
        ),

        decoration: BoxDecoration(
          color: const Color(0xFF101326),

          borderRadius:
              BorderRadius.circular(17),

          border: Border.all(
            color: const Color(
              0xFF24273B,
            ),
          ),
        ),

        child: Row(
          children: [

            const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 29,
            ),

            const SizedBox(width: 20),

            const Expanded(
              child: Text(
                'Logout',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
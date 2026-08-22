

import 'package:get/get.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/screens/projects/project_detail_screen.dart';
import 'package:task_manager/screens/projects/project_list_screen.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () =>  SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () =>  LoginScreen(),
    ),
    GetPage(
  name: AppRoutes.projects,
  page: () => const ProjectListScreen(),
),

GetPage(
  name: AppRoutes.projectDetail,
  page: () => const ProjectDetailScreen(),
),
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreen(),
    ),
  ];
}
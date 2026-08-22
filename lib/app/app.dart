import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TaskFlow',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      initialRoute: AppRoutes.splash,

      getPages: AppPages.pages,

      initialBinding: InitialBinding(),
    );
  }
}
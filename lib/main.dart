// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_manager/app/routes/app_routes.dart';

// import 'app/bindings/initial_binding.dart';
// import 'app/routes/app_pages.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,

//       initialBinding: InitialBinding(),

//       initialRoute: AppRoutes.login,

//       getPages: AppPages.pages,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 MAIN STARTED');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('🚀 MyApp BUILD');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialBinding: InitialBinding(),

      initialRoute: AppRoutes.login,

      getPages: AppPages.pages,
    );
  }
}
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ujikom_piksi/app/modules/dashboard/controllers/dashboard_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.lazyPut(() => DashboardController(), fenix: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      
    ),
  );
}
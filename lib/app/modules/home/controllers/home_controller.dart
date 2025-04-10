import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom_piksi/app/modules/dashboard/views/dashboard_view.dart';

class HomeController extends GetxController {
  late Timer _pindah;
  final authToken = GetStorage();

  @override
  void onInit() {
  super.onInit();

  _pindah = Timer(const Duration(seconds: 4), () {
    Get.off(() => const DashboardView());
  });
}


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _pindah.cancel();
    super.onClose();
  }
}
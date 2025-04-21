import 'package:get/get.dart';
import 'package:ujikom_piksi/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ujikom_piksi/app/modules/berita/controllers/berita_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<BeritaController>(() => BeritaController()); // ✅ Tambahkan ini
  }
}

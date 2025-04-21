import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../berita/controllers/berita_controller.dart'; // ✅ Import controller berita

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pages = controller.pages;
      final index = controller.selectedIndex.value.clamp(0, pages.length - 1); // Hindari index error

      return Scaffold(
        body: IndexedStack(
          index: index,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (newIndex) {
            // ✅ Tambahkan pengecekan saat memilih tab Berita
            if (newIndex == 1 && !Get.isRegistered<BeritaController>()) {
              Get.put(BeritaController());
            }

            controller.changeIndex(newIndex);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Fakultas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Berita',
            ),
          ],
        ),
      );
    });
  }
}

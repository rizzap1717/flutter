import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_piksi/app/modules/berita/views/berita_view.dart';
import 'package:ujikom_piksi/app/utils/api.dart';

import '../../../models/fakultas.dart';
import '../../dashboard/views/index_view.dart';
import 'package:ujikom_piksi/app/modules/berita/controllers/berita_controller.dart';

class DashboardController extends GetxController {
  var fakultasList = <Faculties>[].obs;
  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  final _getConnect = GetConnect();

  final List<Widget> pages = [
    IndexView(),
    // Tambahkan halaman berita di sini
    BeritaView(), // Pastikan Anda memiliki widget BeritaView
  ];

  @override
  void onInit() {
    super.onInit();
    // hanya ambil data jika belum ada
    if (fakultasList.isEmpty) {
      getFakultas();
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;

    // Jika pindah ke halaman Berita (index ke-1), ambil data berita
    if (index == 1) {
      final beritaController = Get.find<BeritaController>();
      beritaController.getBerita(); // Fetch ulang data
    }
  }

  void getFakultas() async {
    try {
      isLoading(true);

      print("Mengambil data dari: ${BaseUrl.fakultas}");

      final response = await _getConnect.get(
        BaseUrl.fakultas,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 && response.body != null) {
        final data = response.body['faculties'];
        if (data != null && data is List) {
          fakultasList.value =
              data.map((json) => Faculties.fromJson(json)).toList();
        } else {
          fakultasList.clear();
        }
      } else {
        Get.snackbar(
          "Error",
          "Gagal mengambil data fakultas",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat mengambil data fakultas",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}

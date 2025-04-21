import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_piksi/app/models/berita.dart';
import 'package:ujikom_piksi/app/data/berita_response.dart';
import 'package:ujikom_piksi/app/utils/api.dart';

class BeritaController extends GetxController {
  var beritaList = <Data>[].obs;
  var isLoading = false.obs;

  final _getConnect = GetConnect();

  @override
  void onInit() {
    super.onInit();
    getBerita(); // Panggil saat controller inisialisasi
  }

  void getBerita() async {
    try {
      isLoading(true);
      print("🔄 Mengambil data berita dari: ${BaseUrl.berita}");

      final response = await _getConnect.get(
        BaseUrl.berita,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print("📦 Response Status: ${response.statusCode}");
      print("📦 Response Body: ${response.body}");

      if (response.statusCode == 200 && response.body != null) {
        final news = News.fromJson(response.body);
        beritaList.value = news.data ?? [];
        print("✅ Data berita berhasil diambil: ${beritaList.length} item");
      } else {
        Get.snackbar(
          "Error",
          "Gagal mengambil data berita",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Error: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat mengambil data berita",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom_piksi/app/utils/api.dart';
import '../../../models/fakultas.dart';
import '../../dashboard/views/index_view.dart';

class DashboardController extends GetxController {
  var fakultasList = <Faculties>[].obs; // Data fakultas
  var isLoading = false.obs; // Status loading
  var selectedIndex = 0.obs; // Untuk BottomNavigationBar

  final _getConnect = GetConnect();

  final List<Widget> pages = [
    IndexView(), // Halaman fakultas
  ];

  @override
  void onInit() {
    super.onInit();
    getFakultas(); // Ambil data fakultas saat aplikasi dibuka
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
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
      List<dynamic> data = response.body['faculties']; // Sesuaikan key dengan JSON dari Postman
      fakultasList.value = data.map((json) => Faculties.fromJson(json)).toList();
    } else {
      Get.snackbar("Error", "Gagal mengambil data fakultas",
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    print("Error: $e");
    Get.snackbar("Error", "Terjadi kesalahan saat mengambil data fakultas",
        snackPosition: SnackPosition.BOTTOM);
  } finally {
    isLoading(false);
  }
}

}

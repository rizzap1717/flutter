import 'package:get/get.dart';
import 'package:ujikom_piksi/app/views/views/berita_view.dart';

import '../modules/berita/bindings/berita_binding.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
  GetPage(
    name: _Paths.HOME,
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: _Paths.DASHBOARD,
    page: () => const DashboardView(),
    binding: DashboardBinding(),
  ),
  GetPage(
    name: _Paths.BERITA,
    page: () => BeritaView(),
    binding: BeritaBinding(),
  ),
];
}

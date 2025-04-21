import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ujikom_piksi/app/modules/berita/controllers/berita_controller.dart';

class BeritaView extends StatelessWidget {
  BeritaView({Key? key}) : super(key: key);

  final controller = Get.put(BeritaController());

  // ✅ DITAMBAHKAN: base URL dari Laravel (ganti sesuai kebutuhan kamu)
  final String baseUrl = "http://127.0.0.1:8000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Berita',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value && controller.beritaList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b438d690b2b7016bc/lottie-loading.json',
                    repeat: true,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Memuat berita...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.beritaList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.newspaper, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "Tidak ada berita saat ini",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Silakan coba lagi nanti",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.beritaList.length,
            itemBuilder: (context, index) {
              final berita = controller.beritaList[index];

              // Try to parse date for formatting
              String formattedDate = berita.date ?? '-';
              try {
                if (berita.date != null && berita.date!.isNotEmpty) {
                  // Ganti format sesuai dengan data dari API-mu
                  // Misalnya jika berita.date = '2025-04-21' (format ISO 8601), ini aman:
                  final parsedDate = DateTime.parse(berita.date!);

                  // Jika formatnya beda, contoh '21-04-2025', pakai:
                  // final parsedDate = DateFormat('dd-MM-yyyy').parse(berita.date!);

                  formattedDate = DateFormat(
                    'dd MMM yyyy',
                    'id_ID',
                  ).format(parsedDate);
                }
              } catch (e) {
                print('Error parsing date: $e');
                // biarkan formattedDate tetap jadi berita.date
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ DIUBAH: Gambar dari Laravel storage with better design
                    if (berita.newsPicture != null &&
                        berita.newsPicture!.isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'http://127.0.0.1:8000/images/news_picture/${berita.newsPicture!}',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image_rounded,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Date badge
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Content container
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul
                          Text(
                            berita.title ?? 'Tanpa Judul',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Author with icon
                          if (berita.authors != null &&
                              berita.authors!.isNotEmpty)
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.indigo,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  berita.authors!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 16),

                          // Divider
                          const Divider(),
                          const SizedBox(height: 12),

                          // Konten
                          Text(
                            berita.content ?? 'Tanpa Konten',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              color: Colors.grey[800],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Read more button
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

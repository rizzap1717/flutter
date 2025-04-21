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
      appBar: AppBar(title: const Text('Daftar Berita'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value && controller.beritaList.isEmpty) {
            return Center(
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b438d690b2b7016bc/lottie-loading.json',
                repeat: true,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            );
          }

          if (controller.beritaList.isEmpty) {
            return const Center(child: Text("Tidak ada data berita."));
          }

          return ListView.builder(
            itemCount: controller.beritaList.length,
            itemBuilder: (context, index) {
              final berita = controller.beritaList[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ DIUBAH: Gambar dari Laravel storage
                      if (berita.newsPicture != null && berita.newsPicture!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'http://127.0.0.1:8000/storage/news_picture/${berita.newsPicture!}',// URL baru
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text("Gagal memuat gambar"); // ✅ DITAMBAHKAN
                            },
                          ),
                        ),

                      const SizedBox(height: 10),

                      // Judul
                      Text(
                        berita.title ?? 'Tanpa Judul',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Penulis dan tanggal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Penulis: ${berita.authors ?? '-'}'),
                          Text('Tanggal: ${berita.date ?? '-'}'),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Konten
                      Text(
                        berita.content ?? 'Tanpa Konten',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

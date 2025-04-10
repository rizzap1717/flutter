class Faculties {
  final int id;
  final String facultyName;
  final String description;
  final DateTime? createdAt; // Bisa null jika datanya kosong
  final DateTime? updatedAt; // Bisa null jika datanya kosong

  Faculties({
    required this.id,
    required this.facultyName,
    required this.description,
    this.createdAt, // Tidak wajib, bisa null
    this.updatedAt, // Tidak wajib, bisa null
  });

  // Konversi dari JSON ke objek
  factory Faculties.fromJson(Map<String, dynamic> json) {
    return Faculties(
      id: json['id'] ?? 0,
      facultyName: json['faculty_name'] ?? "No Name",
      description: json['description'] ?? "No Description",
      createdAt: json['created_at'] != null && json['created_at'].toString().isNotEmpty
          ? DateTime.tryParse(json['created_at']) // Parse tanggal dengan aman
          : null,
      updatedAt: json['updated_at'] != null && json['updated_at'].toString().isNotEmpty
          ? DateTime.tryParse(json['updated_at']) 
          : null,
    );
  }

  // Konversi dari objek ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'faculty_name': facultyName,
      'description': description,
      'created_at': createdAt?.toIso8601String(), // Gunakan `?` agar aman dari null
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class FakultasResponse {
  bool? success;
  String? message;
  List<Faculties>? faculties;

  FakultasResponse({this.success, this.message, this.faculties});

  FakultasResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['faculties'] != null) {
      faculties = <Faculties>[];
      json['faculties'].forEach((v) {
        faculties!.add(new Faculties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.faculties != null) {
      data['faculties'] = this.faculties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faculties {
  int? id;
  String? facultyName;
  String? description;
  String? createdAt;
  String? updatedAt;

  Faculties(
      {this.id,
      this.facultyName,
      this.description,
      this.createdAt,
      this.updatedAt});

  Faculties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facultyName = json['faculty_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['faculty_name'] = this.facultyName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

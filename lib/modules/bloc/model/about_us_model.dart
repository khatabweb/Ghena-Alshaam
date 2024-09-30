class AboutModel {
  int? status;
  String? msg;
  Data? data;

  AboutModel({
    this.status,
    this.msg,
    this.data,
  });
  AboutModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    msg = json['msg']?.toString();
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<About?>? about;

  Data({
    this.about,
  });
  Data.fromJson(Map<String, dynamic> json) {
    if (json['about'] != null) {
      final v = json['about'];
      final arr0 = <About>[];
      v.forEach((v) {
        arr0.add(About.fromJson(v));
      });
      about = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (about != null) {
      final v = about;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['about'] = arr0;
    }
    return data;
  }
}

class About {
  int? id;
  String? file;
  String? createdAt;
  String? updatedAt;

  About({
    this.id,
    this.file,
    this.createdAt,
    this.updatedAt,
  });
  About.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    file = json['file']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

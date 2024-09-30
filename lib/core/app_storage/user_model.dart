import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? success;
  Data? data;
  String? message;

  UserModel({
    this.success,
    this.data,
    this.message,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
    message = json['message']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? token;
  String? name;

  Data({
    this.token,
    this.name,
  });
  Data.fromJson(Map<String, dynamic> json) {
    token = json['token']?.toString();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    return data;
  }
}
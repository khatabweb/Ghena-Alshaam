class OurWayModel {
  int? status;
  String? msg;
  List<Data?>? data;

  OurWayModel({
    this.status,
    this.msg,
    this.data,
  });
  OurWayModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    msg = json['msg']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <Data>[];
      v.forEach((v) {
        arr0.add(Data.fromJson(v));
      });
      this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}

class Data {
  String? myWay;

  Data({
    this.myWay,
  });
  Data.fromJson(Map<String, dynamic> json) {
    myWay = json['my_way']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['my_way'] = myWay;
    return data;
  }
}
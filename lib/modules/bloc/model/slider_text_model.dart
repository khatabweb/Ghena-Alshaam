class SliderTextModel {
  int? status;
  String? msg;
  String? data;

  SliderTextModel({
    this.status,
    this.msg,
    this.data,
  });
  SliderTextModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    msg = json['msg']?.toString();
    data = json['data']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['data'] = this.data;
    return data;
  }
}
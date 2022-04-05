class ErrorModel {
  String? detail;

  ErrorModel({this.detail});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    detail = json["detail"] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    return data;
  }
}

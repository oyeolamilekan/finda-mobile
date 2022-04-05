class PasswordResetModel {
  String? detail;

  PasswordResetModel({this.detail});

  PasswordResetModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    return data;
  }
}

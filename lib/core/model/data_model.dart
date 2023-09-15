class DataModel {
  final bool? isLimit;
  final int? language;

  DataModel({this.isLimit = false, this.language = 1});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      isLimit: json['isLimit'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isLimit'] = isLimit;
    data['language'] = language;
    return data;
  }
}

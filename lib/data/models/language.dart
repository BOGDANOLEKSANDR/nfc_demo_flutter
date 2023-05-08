class Language {
  final int languageId;
  final String? name;
  final String? shortName;
  final String? uiOrder;
  final String? isActive;
  bool isSelected;

  Language({required this.languageId, this.name, this.shortName, this.uiOrder, this.isActive, this.isSelected = false});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageId: int.parse(json['language_id']),
      name: json['name'],
      shortName: json['short_name'],
      uiOrder: json['ui_order'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language_id'] = languageId;
    data['name'] = name;
    data['short_name'] = shortName;
    data['ui_order'] = uiOrder;
    data['is_active'] = isActive;
    data['is_selected'] = isSelected;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  static Language empty = Language(languageId: -1, name: '', shortName: '');
}

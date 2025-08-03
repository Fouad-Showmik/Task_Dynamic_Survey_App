//This model defines the configuration for a single form field,
// including its behavior, appearance, and validation rules.
class PropertiesModel {
  final bool multiSelect;
  final List<String> options;
  final String? label;
  final bool? required;
  final String? hintText;
  final String? defaultValue;
  final int? minLength;
  final int? maxLength;
  final String? listItems;
  final String? type;

  PropertiesModel({
    required this.multiSelect,
    required this.options,
    this.label,
    this.required,
    this.hintText,
    this.defaultValue,
    this.minLength,
    this.maxLength,
    this.listItems,
    this.type,
  });

  factory PropertiesModel.fromJson(Map<String, dynamic> json) {
    return PropertiesModel(
      multiSelect: json['multiSelect'] == true,
      options:
          json['options'] is List
              ? List<String>.from(json['options'])
              : json['options'] != null
              ? [json['options'].toString()]
              : [],
      label: json['label'],
      required: json['required'],
      hintText: json['hintText'],
      defaultValue: json['defaultValue'],
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      listItems: json['listItems'],
      type: json['type'],
    );
  }

  factory PropertiesModel.empty() {
    return PropertiesModel(
      multiSelect: false,
      options: [],
      label: '',
      required: false,
      hintText: '',
      defaultValue: '',
      minLength: 0,
      maxLength: 9999,
      listItems: '[]',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'multiSelect': multiSelect,
      'options': options,
      'label': label,
      'required': required,
      'hintText': hintText,
      'defaultValue': defaultValue,
      'minLength': minLength,
      'maxLength': maxLength,
      'listItems': listItems,
    };
  }
}

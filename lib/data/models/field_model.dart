//Represents a single field in a form.
import 'properties_model.dart';

class FieldModel {
  final int id;
  final String key;
  final PropertiesModel properties;
  dynamic resultValue; // Stores the user's input

  FieldModel({
    required this.id,
    required this.key,
    required this.properties,
    this.resultValue,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'],
      key: json['key'],
      properties:
          json['properties'] != null
              ? PropertiesModel.fromJson(json['properties'])
              : PropertiesModel.empty(),
      resultValue: json['resultValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'properties': properties.toJson(),
      'resultValue': resultValue,
    };
  }

  FieldModel copyWith({
    int? id,
    String? key,
    PropertiesModel? properties,
    dynamic resultValue,
  }) {
    return FieldModel(
      id: id ?? this.id,
      key: key ?? this.key,
      properties: properties ?? this.properties,
      resultValue: resultValue ?? this.resultValue,
    );
  }
}

//Represents a section within a form
import 'field_model.dart';

class SectionModel {
  final String name;
  final String key;
  final List<FieldModel> fields;

  SectionModel({required this.name, required this.key, required this.fields});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      name: json['name'],
      key: json['key'],
      fields:
          (json['fields'] as List<dynamic>)
              .map((f) => FieldModel.fromJson(f as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'key': key,
      'fields': fields.map((f) => f.toJson()).toList(),
    };
  }
}

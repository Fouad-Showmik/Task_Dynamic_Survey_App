import 'section_model.dart';

class FormModel {
  final String formName;
  final int id;
  final List<SectionModel> sections;

  FormModel({required this.formName, required this.id, required this.sections});

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      formName: json['formName'],
      id: json['id'],
      sections:
          (json['sections'] as List)
              .map((e) => SectionModel.fromJson(e))
              .toList(),
    );
  }
}

import 'package:survey/data/models/section_model.dart';

//Returns a map of field results for a single section
Map<String, dynamic> getSectionResults(SectionModel section) {
  final results = <String, dynamic>{};
  for (var field in section.fields) {
    results[field.key] = field.resultValue ?? '';
  }
  return results;
}

//Returns a full form result including all sections
Map<String, dynamic> getFullFormResults(List<SectionModel> sections) {
  final allResults = <String, dynamic>{};
  for (var section in sections) {
    allResults[section.key] = getSectionResults(section);
  }
  return allResults;
}

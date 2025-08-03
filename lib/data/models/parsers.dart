//Converts dynamic JSON into a strongly typed Dart object.
import 'dart:convert';

import 'package:survey/data/models/form_model.dart';

FormModel parseForm(String jsonString) {
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return FormModel.fromJson(jsonMap);
}

//Handles loading JSON form files from the asset bundle and parsing them into usable FormModel objects.
//It abstracts the data source logic from the rest of the app.
import 'package:flutter/foundation.dart'; //
import 'package:flutter/services.dart';
import 'package:survey/data/models/form_model.dart';
import 'package:survey/data/models/parsers.dart';

class FormRepository {
  Future<FormModel> loadForm(String assetPath) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final FormModel parsedForm = await compute(parseForm, jsonString);
    return parsedForm;
  }

  Future<List<FormModel>> loadAllForms() async {
    List<String> paths = [
      'assets/form1.json',
      'assets/form2.json',
      'assets/form3.json',
    ];

    return Future.wait(paths.map((path) => loadForm(path)));
  }
}

//Saves a map of form results to a local JSON file in the app’s internal storage directory.
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveFormToLocal(
  Map<String, dynamic> formResults,
  String filename,
) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$filename.json';

  final file = File(path);
  await file.writeAsString(jsonEncode(formResults), flush: true);

  return path;
}

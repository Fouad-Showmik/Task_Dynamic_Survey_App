//Manages the state of available forms and the currently selected form.
//Acts as a bridge between your UI and the FormRepository.
import 'package:flutter/material.dart';
import 'package:survey/data/models/form_model.dart';
import 'package:survey/data/repositories/form_repository.dart';

class FormProvider extends ChangeNotifier {
  final FormRepository _formRepository = FormRepository();

  List<FormModel> _forms = [];
  FormModel? _selectedForm;

  List<FormModel> get forms => _forms;
  FormModel? get selectedForm => _selectedForm;

  Future<void> loadForms() async {
    _forms = await _formRepository.loadAllForms();
    notifyListeners();
  }

  void selectForm(FormModel form) {
    _selectedForm = form;
    notifyListeners();
  }

  void resetSelection() {
    _selectedForm = null;
    notifyListeners();
  }
}

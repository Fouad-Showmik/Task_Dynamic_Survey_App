import 'package:flutter/material.dart';
import 'package:survey/data/models/form_model.dart';

class FormTile extends StatelessWidget {
  final FormModel form;
  final VoidCallback onTap;

  const FormTile({super.key, required this.form, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(form.formName),
      subtitle: Text('ID: ${form.id}'),
      onTap: onTap,
    );
  }
}

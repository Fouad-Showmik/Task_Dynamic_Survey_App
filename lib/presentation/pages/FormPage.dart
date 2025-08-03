//Displays a complete form based on a FormModel, dynamically rendering sections and fields.
//Handles validation and submission, passing results to a review screen.
import 'package:flutter/material.dart';
import 'package:survey/data/models/form_model.dart';
import 'package:survey/helpers/form_results_helper.dart';
import 'package:survey/presentation/pages/submission_view_page.dart';
import 'package:survey/presentation/widgets/field_renderer.dart';

class FormPage extends StatefulWidget {
  final FormModel form;
  const FormPage({super.key, required this.form});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.form.formName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.form.sections.length,
                  itemBuilder: (context, sectionIndex) {
                    final section = widget.form.sections[sectionIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ...section.fields.map(
                          (field) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: FieldRenderer(field: field),
                          ),
                        ),
                        const Divider(height: 32),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final results = getFullFormResults(widget.form.sections);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => SubmissionViewPage(
                              submission: results,
                              formSections:
                                  widget.form.sections
                                      .map((s) => s.toJson())
                                      .toList(),
                            ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

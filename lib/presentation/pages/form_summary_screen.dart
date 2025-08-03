import 'package:flutter/material.dart';

class FormSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> formResults;
  const FormSummaryScreen({required this.formResults, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Your Responses')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children:
            formResults.entries.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.key,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...((section.value as Map<String, dynamic>).entries.map((
                    field,
                  ) {
                    return Text('${field.key}: ${field.value}');
                  })),
                  const Divider(height: 32),
                ],
              );
            }).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true); // Confirm submission
          },
          child: const Text('Confirm and Submit'),
        ),
      ),
    );
  }
}

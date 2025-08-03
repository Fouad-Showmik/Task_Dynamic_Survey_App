//Displays a detailed view of the submitted form data, grouped by section,
//Allows the user to export the submission as a PDF to the device's Downloads folder.
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class SubmissionViewPage extends StatelessWidget {
  final Map<String, dynamic> submission;
  final List<Map<String, dynamic>> formSections;

  const SubmissionViewPage({
    Key? key,
    required this.submission,
    required this.formSections,
  }) : super(key: key);

  String getSectionName(String sectionKey) {
    final section = formSections.firstWhere(
      (s) => s['key'] == sectionKey,
      orElse: () => <String, dynamic>{},
    );
    return section['name']?.toString() ?? sectionKey;
  }

  String getFieldLabel(String sectionKey, String fieldKey) {
    final section = formSections.firstWhere(
      (s) => s['key'] == sectionKey,
      orElse: () => <String, dynamic>{},
    );
    final fields = section['fields'] as List<dynamic>? ?? [];
    final field = fields.firstWhere(
      (f) => f['key'] == fieldKey,
      orElse: () => <String, dynamic>{},
    );
    return field['properties']?['label']?.toString() ?? fieldKey;
  }

  Widget renderValue(dynamic value) {
    if (value is bool) {
      return Text(value ? 'Yes' : 'No');
    } else if (value is List) {
      return Wrap(
        spacing: 8,
        children: value.map((v) => Chip(label: Text(v.toString()))).toList(),
      );
    } else if (value is String && value.startsWith('/')) {
      final file = File(value);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            file,
            height: 150,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        );
      } else {
        return Text('$value');
      }
    } else {
      return Text(value?.toString() ?? '');
    }
  }

  //method to save PDF to Downloads folder
  Future<String?> savePdfToDownloads(Uint8List pdfBytes) async {
    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      return null;
    }

    final downloadsDir = Directory('/storage/emulated/0/Download');
    if (!downloadsDir.existsSync()) {
      downloadsDir.createSync(recursive: true);
    }

    final filePath =
        '${downloadsDir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);
    return filePath;
  }

  Future<void> saveToPdf(BuildContext context) async {
    try {
      final pdf = pw.Document();

      submission.forEach((sectionKey, sectionData) {
        final sectionName = getSectionName(sectionKey);
        pdf.addPage(
          pw.Page(
            build:
                (pw.Context ctx) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      sectionName,
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    ...((sectionData as Map<String, dynamic>).entries.map((
                      fieldEntry,
                    ) {
                      final fieldKey = fieldEntry.key;
                      final fieldValue = fieldEntry.value;
                      final fieldLabel = getFieldLabel(sectionKey, fieldKey);
                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 4),
                        child: pw.Text('$fieldLabel: $fieldValue'),
                      );
                    })),
                  ],
                ),
          ),
        );
      });

      final pdfBytes = await pdf.save();
      final savedPath = await savePdfToDownloads(pdfBytes);

      if (savedPath != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('PDF saved to: $savedPath')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save PDF')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submission Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...submission.entries.map((sectionEntry) {
            final sectionKey = sectionEntry.key;
            final sectionData = sectionEntry.value as Map<String, dynamic>;
            final sectionName = getSectionName(sectionKey);

            return Card(
              margin: const EdgeInsets.only(bottom: 24),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sectionName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Divider(
                          thickness: 1.2,
                          color: Colors.grey.shade400,
                          endIndent: 0,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...sectionData.entries.map((fieldEntry) {
                      final fieldKey = fieldEntry.key;
                      final fieldValue = fieldEntry.value;
                      final fieldLabel = getFieldLabel(sectionKey, fieldKey);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fieldLabel,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            renderValue(fieldValue),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () => saveToPdf(context),
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Save to Storage'),
          ),
        ],
      ),
    );
  }
}

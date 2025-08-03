import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey/data/models/field_model.dart';

class DropdownFieldWidget extends StatelessWidget {
  final FieldModel field;

  const DropdownFieldWidget({Key? key, required this.field}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[];

    dynamic rawItems = field.properties.listItems;

    List<dynamic> normalizedList = [];

    try {
      if (rawItems is String) {
        final decoded = jsonDecode(rawItems);
        if (decoded is List) {
          normalizedList = decoded;
        }
      } else if (rawItems is List) {
        normalizedList = rawItems;
      }
    } catch (e) {
      debugPrint('Failed to parse listItems: $e');
    }

    for (final item in normalizedList) {
      if (item is Map<String, dynamic>) {
        items.add(item);
      } else if (item is String) {
        items.add({'name': item});
      }
    }

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: field.properties.label ?? 'Select',
      ),
      value: field.resultValue as String?,
      items:
          items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item['name'] as String,
                  child: Text(item['name'] as String),
                ),
              )
              .toList(),
      onChanged: (value) {
        field.resultValue = value;
      },
    );
  }
}

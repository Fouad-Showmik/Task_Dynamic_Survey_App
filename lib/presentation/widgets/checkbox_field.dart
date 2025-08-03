import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey/data/models/field_model.dart';

class CheckBoxListField extends StatefulWidget {
  final FieldModel field;

  const CheckBoxListField({super.key, required this.field});

  @override
  State<CheckBoxListField> createState() => _CheckBoxListFieldState();
}

class _CheckBoxListFieldState extends State<CheckBoxListField> {
  late List<String> selectedItems;
  @override
  void initState() {
    super.initState();
    selectedItems = List<String>.from(widget.field.resultValue ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final props = widget.field.properties;

    final items = List<Map<String, dynamic>>.from(
      jsonDecode(props.listItems ?? '[]'),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(props.label ?? 'Select options'),
        ...items.map(
          (item) => CheckboxListTile(
            title: Text(item['name']),
            value: selectedItems.contains(item['name']),
            onChanged: (val) {
              setState(() {
                val == true
                    ? selectedItems.add(item['name'])
                    : selectedItems.remove(item['name']);
                widget.field.resultValue = selectedItems;
              });
            },
          ),
        ),
      ],
    );
  }
}

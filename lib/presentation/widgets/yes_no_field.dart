import 'package:flutter/material.dart';
import 'package:survey/data/models/field_model.dart';

class YesNoFieldWidget extends StatefulWidget {
  final FieldModel field;

  const YesNoFieldWidget({super.key, required this.field});

  @override
  State<YesNoFieldWidget> createState() => _YesNoFieldWidgetState();
}

class _YesNoFieldWidgetState extends State<YesNoFieldWidget> {
  bool? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.field.resultValue as bool?;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.field.properties.label ?? 'Select'),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: selectedValue,
              onChanged: (val) {
                setState(() {
                  selectedValue = val;
                  widget.field.resultValue = val;
                });
              },
            ),
            const Text("Yes"),
            Radio<bool>(
              value: false,
              groupValue: selectedValue,
              onChanged: (val) {
                setState(() {
                  selectedValue = val;
                  widget.field.resultValue = val;
                });
              },
            ),
            const Text("No"),
          ],
        ),
      ],
    );
  }
}

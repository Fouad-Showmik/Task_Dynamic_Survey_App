//Acts as a factory widget that chooses the correct UI component for a given FieldModel, based on its id and properties.
import 'package:flutter/material.dart';
import 'package:survey/data/models/field_model.dart';
import 'package:survey/presentation/widgets/checkbox_field.dart';
import 'package:survey/presentation/widgets/drop_down_field.dart';
import 'package:survey/presentation/widgets/image_field.dart';
import 'package:survey/presentation/widgets/text_field_widget.dart';
import 'package:survey/presentation/widgets/yes_no_field.dart';

class FieldRenderer extends StatelessWidget {
  final FieldModel field;

  const FieldRenderer({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final props = field.properties;

    switch (field.id) {
      case 1: // TextField
        return TextFieldWidget(field: field);

      case 2: // List (Dropdown or Checkbox)

        return props.multiSelect == true
            ? CheckBoxListField(field: field)
            : DropdownFieldWidget(field: field);

      case 3: // Yes/No/NA
        return YesNoFieldWidget(field: field);

      case 4: // Image Picker
        return ImageFieldWidget(field: field);

      default:
        return const SizedBox.shrink();
    }
  }
}

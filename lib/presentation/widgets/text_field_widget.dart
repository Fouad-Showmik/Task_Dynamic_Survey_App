import 'package:flutter/material.dart';
import 'package:survey/core/validate.dart';
import 'package:survey/data/models/field_model.dart';
import 'package:survey/presentation/widgets/field_renderer.dart';

class TextFieldWidget extends StatelessWidget {
  final FieldModel field;

  const TextFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final props = field.properties;

    return TextFormField(
      decoration: InputDecoration(
        labelText: props.label,
        hintText: props.hintText,
      ),
      initialValue: props.defaultValue,
      validator: (value) {
        final label = props.label?.toLowerCase() ?? '';
        final min = props.minLength ?? 0;
        final max = props.maxLength ?? 9999;

        // Conditional validation for "If yes, specify"
        if (label.contains('specify')) {
          final allergyField = _findAllergyField(context);
          final rawValue = allergyField?.resultValue;

          final selected =
              rawValue is bool
                  ? rawValue
                  : rawValue?.toString().toLowerCase() == 'yes';

          if (selected == true && (value == null || value.trim().isEmpty)) {
            return 'Please specify your allergies';
          }

          // If "No" is selected, skip all other validations for this field
          return null;
        }

        // Required length validation
        final requiredError = validateRequired(value, min: min, max: max);
        if (requiredError != null) return requiredError;

        if (label.contains('full name')) {
          return validateFullName(value!);
        }
        if (label.contains('email')) {
          return validateEmail(value!);
        }
        if (label.contains('address')) {
          return validatePropertyAddress(value!);
        }
        if (label.contains('area')) {
          return validateArea(value!);
        }
        if (label.contains('patient name')) {
          return validatePatientName(value!);
        }
        if (label.contains('age')) {
          return validateAge(value!);
        }

        return null;
      },
      onChanged: (value) => field.resultValue = value,
    );
  }

  FieldModel? _findAllergyField(BuildContext context) {
    final formWidget = context.findAncestorWidgetOfExactType<Form>();
    if (formWidget == null) return null;

    final fields = <FieldModel>[];

    void visitor(Element element) {
      if (element.widget is FieldRenderer) {
        final renderer = element.widget as FieldRenderer;
        fields.add(renderer.field);
      }
      element.visitChildren(visitor);
    }

    final formContext = (formWidget.key as GlobalKey<FormState>).currentContext;
    if (formContext == null) return null;

    formContext.visitChildElements(visitor);

    for (final f in fields) {
      final label = f.properties.label?.toLowerCase() ?? '';
      if (label.contains('any allergies')) {
        return f;
      }
    }
    return null;
  }
}

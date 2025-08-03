//This section basically validates the information entered by the user.
String? validateRequired(String? value, {int min = 0, int max = 9999}) {
  if (value == null || value.trim().isEmpty) return 'Required';
  if (value.length < min) return 'Min $min characters';
  if (value.length > max) return 'Max $max characters';
  return null;
}

String? validateEmail(String value) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com|outlook\.com)$',
  );
  return emailRegex.hasMatch(value)
      ? null
      : 'Invalid email or unsupported domain';
}

String? validatePropertyAddress(String value) {
  final hasAlphabet = RegExp(r'[a-zA-Z]').hasMatch(value);
  return hasAlphabet ? null : 'Address must contain at least one letter';
}

String? validateArea(String value) {
  final isNumeric = double.tryParse(value);
  return isNumeric != null ? null : 'Area must be a valid number';
}

String? validatePatientName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Patient name is required.';
  }

  final regex = RegExp(r'^[A-Za-z\s]+$');
  if (!regex.hasMatch(value)) {
    return 'Only alphabets are allowed.';
  }

  return null;
}

String? validateAge(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Age is required.';
  }

  final numValue = int.tryParse(value);
  if (numValue == null || numValue < 1 || numValue > 999) {
    return 'Enter a valid age (1–999).';
  }

  return null;
}

String? validateFullName(String value) {
  final nameRegex = RegExp(r'^[A-Za-z\s]+$');
  if (!nameRegex.hasMatch(value.trim())) {
    return 'Only letters and spaces are allowed';
  }
  return null;
}

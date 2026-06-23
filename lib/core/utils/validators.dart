class Validators {
  const Validators._();

  /// Validates Ukrainian phone number (+380XXXXXXXXX, 13 chars total)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть номер телефону';
    }

    final phone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (!RegExp(r'^\+380\d{9}$').hasMatch(phone)) {
      return 'Невірний формат номера. Використовуйте +380XXXXXXXXX';
    }

    return null;
  }

  /// Validates email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть email';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Невірний формат email';
    }

    return null;
  }

  /// Validates password (8+ chars, uppercase, lowercase, digit, symbol)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть пароль';
    }

    if (value.length < 8) {
      return 'Пароль повинен містити щонайменше 8 символів';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Пароль повинен містити велику літеру';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Пароль повинен містити малу літеру';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Пароль повинен містити цифру';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Пароль повинен містити спеціальний символ';
    }

    return null;
  }

  /// Validates required field
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? 'Введіть $fieldName' : 'Обов\'язкове поле';
    }
    return null;
  }

  /// Validates phone or email (for login)
  static String? validatePhoneOrEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть телефон або email';
    }

    final isPhone = value.startsWith('+') || RegExp(r'^\d').hasMatch(value);
    if (isPhone) {
      return validatePhone(value);
    }

    return validateEmail(value);
  }
}

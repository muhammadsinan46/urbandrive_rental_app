class FormValidator {
  String? validatename(String? fullnamefield, String? name) {
    if (name == null || name.isEmpty) {
      return '$fullnamefield is required';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      return 'invalid email address';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "password is required";
    }

    if (password.length < 6) {
      return 'password must be at least 6 characters long';
    }

    // if (!password.contains(r'[A-Z]')) {
    //   return 'password  must contain at least one uppercase letter';
    // }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'password  must contain at least one number';
    }

    return null;
  }
}

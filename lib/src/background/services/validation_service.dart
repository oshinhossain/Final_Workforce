class ValidationService {
  String? validateUsername(String value) {
    return value.isEmpty
        ? null
        : value.length > 2
            ? null
            : 'Enter valid username';
  }

  String? validateFullName(String value) {
    return value.isEmpty
        ? null
        : value.length > 2
            ? null
            : 'Enter your full name';
  }

  String? validateMobileNumber(String value) {
    return value.isEmpty
        ? null
        : value.length >= 11
            ? null
            : 'Enter valid mobile number';
  }

  String? validateEmail(String value) {
    return value.isEmpty
        ? null
        : value.contains('@')
            ? null
            : 'Enter valid email';
  }

  String? validateAddress(String value) {
    return value.isEmpty
        ? null
        : value.length > 3
            ? null
            : 'Enter your address';
  }

  String? validateOtp(String value) {
    return value.isEmpty
        ? null
        : value.length == 4
            ? null
            : 'Enter valid otp';
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])[a-zA-Z0-9]{10,}$';
    RegExp regExp = RegExp(pattern);
    var isValid = regExp.hasMatch(value);

    return value.isEmpty
        ? null
        : isValid && value.length >= 10
            ? null
            : 'Password must be at least 10 characters in length. It must contain a minimum of 1 lower case letter [a-z] and a minimum of 1 upper case letter [A-Z] and a minimum of 1 numeric character [0-9]. Please don\'t use any special characters.';
  }

  bool isPasswordValid(String value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])[a-zA-Z0-9]{10,}$';
    RegExp regExp = RegExp(pattern);
    var isValid = regExp.hasMatch(value);

    return isValid && value.length >= 10 ? true : false;
  }

  String? validateConfirmPassword(String old, String current) {
    return current.isEmpty
        ? null
        : old == current
            ? null
            : 'Password did not matched';
  }

  // Forgot Password validate
  String? validateResetNewPassword(String value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])[a-zA-Z0-9]{10,}$';
    RegExp regExp = RegExp(pattern);
    var isValid = regExp.hasMatch(value);

    return value.isEmpty
        ? null
        : isValid && value.length >= 10
            ? null
            : 'Password must be at least 10 characters in length. It must contain a minimum of 1 lower case letter [a-z] and a minimum of 1 upper case letter [A-Z] and a minimum of 1 numeric character [0-9]. Please don\'t use any special characters.';
  }

  String? validateResetConfirmPassword(String old, String current) {
    return current.isEmpty
        ? null
        : old == current
            ? null
            : 'New Password and Confirm password does not match.';
  }
}

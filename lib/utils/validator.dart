class InputValidator {
  final RegExp _validInputPattern = RegExp(r'^[a-zA-Z0-9 ]+$');
  bool isNameValid(String name) {
    // Regex pattern to match only alphabetic characters
    final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    // Check if the name matches the pattern
    return regex.hasMatch(name);
  }

  bool containsNumbers(String value) {
    // Regular expression to check if the string contains numbers
    final RegExp regex = RegExp(r'[0-9]');
    return regex.hasMatch(value);
  }

  String? isFullNameValid(String name, String target) {
    if (name.isEmpty) {
      return "Please Enter Your $target";
    }
    if (name.length > 50) {
      return "$target length must be less than 50";
    }
    if (!isNameValid(name)) {
      return "Please Enter Valid $target";
    }
    if (containsNumbers(name)) {
      return "Please Enter Valid $target";
    }

    return null;
  }

  String? isPhoneValid(String phone) {
    if (phone.isEmpty) {
      return "Please Enter Phone Number";
    }
    if (phone.length < 9) {
      return "Phone Number length must be 9";
    }
    if (!(phone.startsWith('9') || phone.startsWith('7'))) {
      return "Phone number can only start with 9 or 7";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return 'Please remove any special characters';
    }

    return null;
  }

  String? isValidField(String data, String tar) {
    if (data.isEmpty) {
      return "Please enter $tar";
    }
    if (data.length > 50) {
      return "Please enter valid $tar";
    }
    if (!_validInputPattern.hasMatch(data)) {
      return 'Please remove any special characters  ';
    }
    return null;
  }

  bool _validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  String? isEmailValid(String email) {
    if (email.isEmpty) {
      return "Please Enter Your Email";
    } else if (!_validEmail(email)) {
      return "Please Enter Valid Email";
    }
    return null;
  }

  bool isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    final bool isValidScheme = uri?.scheme == 'http' || uri?.scheme == 'https';
    final bool hasAuthority = uri?.hasAuthority ?? false;

    return isValidScheme && hasAuthority;
  }

  String? isLinkValid(String link) {
    if (link.isEmpty) {
      return "Please enter link";
    }
    if (!isValidUrl(link)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  String? isPasswordValid(String password) {
    if (password.isEmpty) {
      return "Please Enter Your Pin";
    } else if (password.length < 4) {
      return "Pin length must be greater than or equal to 4";
    } else if (password.length > 25) {
      return "Pin length must be less than 25";
    }
    return null;
  }

  String? isPasswordMatch(String password1, String password2) {
    if (isPasswordValid(password1) == null &&
        isPasswordValid(password2) == null &&
        password1 == password2) {
      return null;
    } else if (password2.isEmpty) {
      return "Please Confirm Your Pin";
    } else if (password2.length < 4) {
      return "Pin length must be greater than or equal to 4";
    }
    return "Pin Didn't Match";
  }
}

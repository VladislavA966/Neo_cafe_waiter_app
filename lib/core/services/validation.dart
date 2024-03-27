mixin ValidationMixin {
  bool validateLogin(String login) {
    if (login.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

class RegisterDelegate {
  bool isFirstLogin = false;

  RegisterDelegate({bool? isFirstLogin}) : isFirstLogin = isFirstLogin ?? false;

  void setFirstLogin() {
    isFirstLogin = true;
  }

  void clearFirstLogin() {
    isFirstLogin = false;
  }
}

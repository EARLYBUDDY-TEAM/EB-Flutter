class LoginDelegate {
  bool isSuccess = false;

  LoginDelegate({bool? isSuccess}) : isSuccess = isSuccess ?? false;

  void setLoginSuccess() {
    isSuccess = true;
  }

  void clearIsSuccess() {
    isSuccess = false;
  }
}

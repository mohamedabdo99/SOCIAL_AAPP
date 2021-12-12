
abstract class LoginStates{}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucessState extends LoginStates {
  final String uId;
  LoginSucessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}

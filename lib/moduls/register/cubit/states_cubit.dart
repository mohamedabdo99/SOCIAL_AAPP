
abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterAccessState extends RegisterStates {

}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates {
  final String uId;

  CreateUserSuccessState(this.uId);
}

class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

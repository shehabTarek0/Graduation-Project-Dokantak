abstract class RegisterUserStates{}
class RegisterUserInitialState extends RegisterUserStates{}
class RegisterUserLoadingState extends RegisterUserStates{}
class RegisterUserSuccesState extends RegisterUserStates{}
class RegisterUserErrorState extends RegisterUserStates{
  RegisterUserErrorState(e);
}
class RegisterUserPassVisState extends RegisterUserStates{}
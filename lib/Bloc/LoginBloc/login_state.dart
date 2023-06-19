part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

// ----------------------------------------------------------
// Loading state

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

// -----------------------------------------------------------
// Success state

class Loginsuccess extends LoginState {
  
  @override
  List<Object?> get props => [];
}

// -----------------------------------------------------------
// failure state

class Loginfail extends LoginState {
  final String? errmsg;
  Loginfail({required this.errmsg});

  @override
  List<Object?> get props => [errmsg];
}

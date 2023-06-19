part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable {}
// ---------------------------------------------------------------
// initial
class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
// ----------------------------------------------------------------
// Loading
class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
// ----------------------------------------------------------------
// success
class RegisterSuccess extends RegisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
// ----------------------------------------------------------------
// Fail
class RegisterFail extends RegisterState {
  final String? errormessage;
  
  RegisterFail({required this.errormessage});

  @override
  List<Object?> get props => [errormessage];
}
// ----------------------------------------------------------------
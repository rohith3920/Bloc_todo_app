part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {}

class LoadRegisterEvent extends RegisterEvent {
  String? name;
  String? email;
  int? mobile;
  String? password;
  String? confirmpassword;

  LoadRegisterEvent(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.password,
      required this.confirmpassword});

  @override
  List<Object?> get props => [name, email, mobile, password, confirmpassword];
}

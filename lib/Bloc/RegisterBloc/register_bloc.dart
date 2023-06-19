import 'package:bloc/bloc.dart';
import 'package:client/repository/signuprepo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterRepo registerRepo) : super(RegisterInitial()) {
    on<LoadRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await registerRepo.userRegister(
          name: event.name ?? "",
          email: event.email ?? "",
          mobile: event.mobile ?? 0,
          password: event.password ?? "",
          confirmpassword: event.confirmpassword ?? "");
      if (result != "Email already exist!" ||
          result != "Please choose a strong password" ||
          result != "Password Doesn't match!" ||
          result != "Please fill all the fields!") {
        emit(RegisterSuccess());
      }
      if (result == "Email already exist!" ||
          result == "Please choose a strong password" ||
          result == "Password Doesn't match!" ||
          result == "Please fill all the fields!") {
        emit(RegisterFail(errormessage: result));
      }
    });
  }
}

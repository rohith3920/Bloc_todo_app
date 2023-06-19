import 'package:bloc/bloc.dart';
import 'package:client/Bloc/LoginBloc/login_event.dart';
import 'package:client/repository/loginrepo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginRepository loginRepository) : super(LoginInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await loginRepository.userLogin(
          email: event.email ?? "", password: event.password ?? "");

      if (result != "Incorrect email ❌👎!" ||
          result != "incorrect Password ❌👎!" ||
          result != "please fill all the fields") {
        emit(Loginsuccess());
      }
      if (result == "Incorrect email ❌👎!" ||
          result == "incorrect Password ❌👎!" ||
          result == "please fill all the fields") {
        emit(Loginfail(errmsg: result));
        print(result);
      }
    });
  }
}

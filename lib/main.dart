import 'dart:io';
import 'package:client/Bloc/LoginBloc/login_bloc.dart';
import 'package:client/Bloc/RegisterBloc/register_bloc.dart';
import 'package:client/Bloc/TodoBloc/gettodo_bloc.dart';
import 'package:client/repository/deletetodorepo.dart';
import 'package:client/repository/gettodorepo.dart';
import 'package:client/repository/positodorepo.dart';
import 'package:client/repository/signuprepo.dart';
import 'package:client/repository/updatetodorepo.dart';
import 'package:client/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/loginrepo.dart';

// this is for local api
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // to remove error red screen
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Material();
  };
  // ----------------------------------------------------
  runApp(const FlutterTodoapp());
  HttpOverrides.global = MyHttpOverrides();

  // register
  // RegisterRepo authlogin = RegisterRepo();
  // authlogin.userRegister(
  //     name: 'mr chocolate',
  //     email: "chocolate@gmail.com",
  //     mobile: 1236547899,
  //     password: "Chocolate@123",
  //     confirmpassword: 'Chocolate@123');
  // -------------------------------------------------------------
  // login
  // LoginRepository authlogin = LoginRepository();
  // authlogin.userLogin(
  //     email: "chocolate@gmail.com", password: "Chocolate@123");
  // --------------------------------------------------------------
  // Gettodos 
  // GettodoRepo gettodoRepo = GettodoRepo();
  // gettodoRepo.Gettodos();
  // --------------------------------------------------------------
  // Posttodos
  // PosttodoRepo gettodoRepo = PosttodoRepo();
  // gettodoRepo.Posttodos(task: '1234');
  // -------------------------------------------------------------
  // Updatetodos
  // UpdatetodoRepo updatetodoRepo = UpdatetodoRepo();
  // updatetodoRepo.Updatetodos(task: '1234', id: '645b576795f3133510d36c21');
  // --------------------------------------------------------------
  // Deletetodos
  // DeletetodoRepo deletetodoRepo = DeletetodoRepo();
  // deletetodoRepo.deletetodos(id: '645b45c195f3133510d36be4');
}

class FlutterTodoapp extends StatelessWidget {
  const FlutterTodoapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc(LoginRepository())),
          BlocProvider(create: (context) => RegisterBloc(RegisterRepo())),
          BlocProvider(
              create: (context) =>
                  GettodoBloc(GettodoRepo())..add(GetTodoEvent())),
          BlocProvider(create: (context) => PosttodoBloc(PosttodoRepo())),
          BlocProvider(create: (context) => UpdatetodoBloc(UpdatetodoRepo())),
          BlocProvider(create: (context) => DeletetodoBloc(DeletetodoRepo())),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ));
  }
}

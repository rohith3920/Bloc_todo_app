import 'package:client/Bloc/LoginBloc/login_bloc.dart';
import 'package:client/Bloc/LoginBloc/login_event.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/registerscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc? loginBloc;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _email =
      TextEditingController(text: "chocolate@gmail.com");
  final TextEditingController _password =
      TextEditingController(text: "Chocolate@123");

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 74, 0, 87),
            ),
          );
        }

        if (state is Loginsuccess) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen(
                    email: _email.text,
                  )));
        }

        if (state is Loginfail) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errmsg.toString())));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: const Image(
                              image: AssetImage("images/loginpng.png"))),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextFormField(
                          controller: _email,
                          validator: (value) {
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "enter email or username..",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextFormField(
                          validator: (value) {
                            return null;
                          },
                          controller: _password,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "enter password**",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.blue)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.red)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "Dont have an account 😢",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        const WidgetSpan(
                          child: SizedBox(
                            width: 7,
                          ),
                        ),
                        TextSpan(
                            text: "Register!",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Registerscreen()));
                              },
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.green,
                                fontWeight: FontWeight.w500))
                      ])),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                loginBloc?.add(
                                  LoadUserEvent(
                                      email: _email.text,
                                      password: _password.text),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: loginBloc?.state is LoginLoading
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ))),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

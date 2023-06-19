import 'package:client/Bloc/RegisterBloc/register_bloc.dart';
import 'package:client/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  RegisterBloc? registerbloc;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    registerbloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 74, 0, 87),
            ),
          );
        }
        if (state is RegisterSuccess) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
        if (state is RegisterFail) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Registerscreen()));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errormessage.toString())));
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
                      Container(
                          child: const Image(
                              image: AssetImage("images/register.jpg"))),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextFormField(
                          controller: _name,
                          validator: (value) {
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "enter name..",
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
                          controller: _mobile,
                          validator: (value) {
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "enter Mobile Number..",
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
                          controller: _password,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "enter password**",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blue))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: TextFormField(
                          controller: _confirmpassword,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Confirm password**",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blue))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "Already have an account 😊",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        const WidgetSpan(
                          child: SizedBox(
                            width: 7,
                          ),
                        ),
                        TextSpan(
                            text: "Login!",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
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
                                registerbloc?.add(LoadRegisterEvent(
                                    name: _name.text,
                                    email: _email.text,
                                    mobile: int.parse(_mobile.text),
                                    password: _password.text,
                                    confirmpassword: _confirmpassword.text));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: registerbloc?.state is RegisterLoading
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        "Register",
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

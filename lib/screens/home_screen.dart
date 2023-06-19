import 'package:client/Bloc/TodoBloc/gettodo_bloc.dart';
import 'package:client/model/todomodel.dart';
import 'package:client/repository/deletetodorepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  const HomeScreen({required this.email, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GettodoBloc? _gettodoBloc;
  PosttodoBloc? posttodoBloc;
  DeletetodoBloc? _deletetodoBloc;
  UpdatetodoBloc? _updatetodoBloc;

  bool isposttodo = true, isupdatetodo = false;

  String? updatetask, updateid;

  final formLoginKey = GlobalKey<FormState>();
  final formupdateKey = GlobalKey<FormState>();
  final TextEditingController taskcontroller = TextEditingController();
  final TextEditingController updatecontroller = TextEditingController();
  DeletetodoRepo deletetodoRepo = DeletetodoRepo();

  @override
  void initState() {
    super.initState();
    _gettodoBloc = context.read<GettodoBloc>();
    posttodoBloc = BlocProvider.of<PosttodoBloc>(context);
    _deletetodoBloc = BlocProvider.of<DeletetodoBloc>(context);
    _updatetodoBloc = BlocProvider.of<UpdatetodoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.email ?? ""),
        ),
        body: BlocConsumer<GettodoBloc, GettodoState>(
          listener: (context, state) {
            if (State is GettodoLoading) {
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 74, 0, 87),
                ),
              );
            }
            if (state is GettodoError) {
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 74, 0, 87),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            }
          },
          builder: (context, state) {
            if (state is Gettodosuccess) {
              List<GettodoModel> todos = state.todo;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // ---------------------------------------------------------------------------------------------------
                    // posttodo
                    BlocConsumer<PosttodoBloc, PosttodoState>(
                      listener: (context, state) {
                        if (state is PosttodoLoading) {
                          // const SizedBox(
                          //   height: 20,
                          //   width: 20,
                          //   child: CircularProgressIndicator(
                          //     color: Color.fromARGB(255, 74, 0, 87),
                          //   ),
                          // );
                        }
                        if (state is Posttodosuccess) {
                          _gettodoBloc?.add(GetTodoEvent());

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Task Posted Successfully')));
                          setState(() {
                            taskcontroller.text = "";
                          });
                        }
                        if (state is PosttodoError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error.toString())));
                        }
                      },
                      builder: (context, state) {
                        return Visibility(
                          visible: isposttodo,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.98,
                            child: Form(
                              key: formLoginKey,
                              child: TextFormField(
                                controller: taskcontroller,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (taskcontroller.text.isEmpty) {
                                    return "Please Enter task";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Enter task",
                                  // label: Text("task"),
                                  // prefixIcon: IconButton(
                                  //     onPressed: () {
                                  //       taskcontroller.text = "";
                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.clear,
                                  //       color: Colors.green,
                                  //     )),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        if (formLoginKey.currentState!
                                            .validate()) {
                                          posttodoBloc?.add(PostEvent(
                                              task: taskcontroller.text));
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.green,
                                      )),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // ---------------------------------------------------------------------------------------------------
                    // updatetodo
                    BlocConsumer<UpdatetodoBloc, UpdatetodoState>(
                      listener: (context, state) {
                        if (state is UpdatetodoLoading) {
                          // const SizedBox(
                          //   height: 20,
                          //   width: 20,
                          //   child: CircularProgressIndicator(
                          //     color: Color.fromARGB(255, 74, 0, 87),
                          //   ),
                          // );
                        }
                        if (state is Updatetodosuccess) {
                          _gettodoBloc?.add(GetTodoEvent());
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Task Updated Successfully')));
                          setState(() {
                            updatecontroller.text = "";
                          });
                        }
                        if (state is UpdatetodoError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error.toString())));
                        }
                      },
                      builder: (context, state) {
                        return Visibility(
                          visible: isupdatetodo,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.98,
                            child: Form(
                              key: formupdateKey,
                              child: TextFormField(
                                controller: updatecontroller,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "update task",
                                  // label: Text("task"),
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        updatecontroller.text = "";
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.green,
                                      )),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _updatetodoBloc?.add(UpdateEvent(
                                          task: updatecontroller.text,
                                          id: updateid ?? "",
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.green,
                                      )),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // ---------------------------------------------------------------------------------------------------
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Card(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                todos[index].task,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        isposttodo = false;
                                                        isupdatetodo = true;
                                                        updatetask =
                                                            todos[index].task;
                                                        updateid =
                                                            todos[index].id;
                                                        print(
                                                            "----------$updatetask");
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Colors.cyan,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  // ---------------------------------------------------------------
                                                  // delete
                                                  BlocConsumer<DeletetodoBloc,
                                                      DeletetodoState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is DeletetodoLoading) {
                                                        // const SizedBox(
                                                        //   height: 20,
                                                        //   width: 20,
                                                        //   child:
                                                        //       CircularProgressIndicator(
                                                        //     color:
                                                        //         Color.fromARGB(
                                                        //             255,
                                                        //             74,
                                                        //             0,
                                                        //             87),
                                                        //   ),
                                                        // );
                                                      }
                                                      if (state
                                                          is Deletetodosuccess) {
                                                        _gettodoBloc?.add(
                                                            GetTodoEvent());
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Task Deleted Successfully')));
                                                      }
                                                      if (state
                                                          is DeletetodoError) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(state
                                                                    .error
                                                                    .toString())));
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _deletetodoBloc?.add(
                                                                DeleteEvent(
                                                                    id: todos[
                                                                            index]
                                                                        .id));
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  // -----------------------------------------------------------------
                                                ],
                                              )
                                            ],
                                          ))),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }
}

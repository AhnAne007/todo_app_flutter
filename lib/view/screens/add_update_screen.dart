import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/resources/db_helper.dart';

class AddUpdatePage extends StatefulWidget {
  const AddUpdatePage({Key? key}) : super(key: key);

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  DBHelper? dbHelper;
  late Future<List<Todo>> todoList;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    todoList = dbHelper!.getListOfTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Update Page",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        elevation: 0,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.help_outline_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            hintText: "Enter Task Title",
                            labelText: "Task Title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Some Text";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: descController,
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: "Enter Task Description",
                          labelText: "Task Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Some Text";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                primary: Colors.amberAccent,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              // String res = await AuthMethods().loginUser(
                              //     email: _emailController.text,
                              //     password: _passwordController.text);
                              // if (res == "Success") {
                              //   ClearFields();
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) {
                              //         return HomeScreen();
                              //       },
                              //     ),
                              //   );
                              // } else {
                              //   final snackBar = SnackBar(
                              //     content: const Text('User Not Found!'),
                              //     action: SnackBarAction(
                              //       label: 'OK',
                              //       onPressed: () {
                              //
                              //         // Some code to undo the change.
                              //       },
                              //     ),
                              //   );
                              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              // }
                            },
                            child: Text(
                              "Submit".toUpperCase(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                primary: Colors.redAccent,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              clearFields();
                            },
                            child: Text(
                              "Clear".toUpperCase(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clearFields() {
    setState(() {
      titleController.text = "";
      descController.text = "";
    });
  }
}

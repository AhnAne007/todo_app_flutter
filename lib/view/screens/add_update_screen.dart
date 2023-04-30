import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/resources/db_helper.dart';
import 'package:to_do_app/view/screens/home_screen.dart';

class AddUpdatePage extends StatefulWidget {
  AddUpdatePage({
    Key? key,
    Todo? todo,
    bool? isUpdate,
  })  : todo = todo,
        isUpdate = isUpdate,
        super(key: key);

  Todo? todo;
  bool? isUpdate;

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  DBHelper? dbHelper;
  late Future<List<Todo>> todoList;
  final _formKey = GlobalKey<FormState>();

  // final titleController = TextEditingController();
  // final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();

    loadData();
  }

  void loadData() async {
    todoList = dbHelper!.getListOfTodos();
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.todo?.title);
    final descController =
        TextEditingController(text: widget.todo?.description);

    return Scaffold(
      appBar: AppBar(
        title: widget.isUpdate == true
            ? Text("Update Page",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ))
            : Text("Add Page",
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
                            print(widget.todo?.title);
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
                                backgroundColor: Colors.amberAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.isUpdate == true) {
                                  dbHelper!.update(Todo(
                                      id: widget.todo!.id,
                                      title: titleController.text,
                                      description: descController.text,
                                      status: 0,
                                      dateAndTime: DateFormat('yMd')
                                          .add_jm()
                                          .format(DateTime.now())
                                          .toString()));
                                  print(titleController.text);
                                  print('Data updated');
                                  titleController.text = '';
                                  descController.text = '';
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                } else {
                                  dbHelper!.insert(Todo(
                                      title: titleController.text,
                                      description: descController.text,
                                      status: 0,
                                      dateAndTime: DateFormat('yMd')
                                          .add_jm()
                                          .format(DateTime.now())
                                          .toString()));
                                  print('Data Added');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                }
                              }
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
                                backgroundColor: Colors.redAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            onPressed: () {},
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
}

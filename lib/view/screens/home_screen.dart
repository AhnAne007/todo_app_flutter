import 'package:flutter/material.dart';
import 'package:to_do_app/resources/db_helper.dart';
import 'package:to_do_app/view/screens/add_update_screen.dart';

import '../../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper? dbHelper;
  late Future<List<Todo>> todoList;

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
        title: Text("My ToDo App",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.help_outline_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: todoList,
            builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No Tasks Found",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return Container();
                // return ListView(
                //   shrinkWrap: true,
                // );
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.limeAccent[400],
        tooltip: 'Add Task',
        child: const Icon(Icons.add,color: Colors.black,),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUpdatePage()));
        },
      ),
    );
  }
}

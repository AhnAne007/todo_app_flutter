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
              } else if (snapshot.data!.length == 0) {
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
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    int toDoId = snapshot.data![index].id!.toInt();
                    String toDoTitle = snapshot.data![index].title.toString();
                    String toDoDescription =
                        snapshot.data![index].description.toString();
                    String toDoDateAndTime =
                        snapshot.data![index].dateAndTime.toString();
                    int toDoStatus = snapshot.data![index].status!.toInt();
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: toDoStatus == 0
                            ? Colors.yellow.shade300
                            : Colors.lightGreenAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                toDoTitle,
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            subtitle: Text(
                              toDoDescription,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  toDoDateAndTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){},
                                  child: Icon(
                                    Icons.edit_note,
                                    color: Colors.deepPurpleAccent,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.limeAccent[400],
        tooltip: 'Add Task',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUpdatePage()));
        },
      ),
    );
  }
}

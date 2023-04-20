//Making a model class for a ToDo object

class Todo {
  final int? id;
  final String? title;
  final String? description;
  final String? dateAndTime;

  //Constructor
  Todo({this.id, this.title, this.description, this.dateAndTime});

  Todo.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        title = result['title'],
        description = result['description'],
        dateAndTime = result['dateAndTime'];

  //Function to convert into Map;
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateAndTime": dateAndTime,
    };
  }
}

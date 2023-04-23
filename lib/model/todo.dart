
class Todo {
  final int? id;
  final String? title;
  final String? description;
  final String? dateAndTime;
  final int? status;

  Todo(
      {
        this.id, this.title,
        this.description,
        this.dateAndTime,
        this.status
      }
  );

  Todo.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        title = result['title'],
        description = result['description'],
        dateAndTime = result['dateAndTime'],
        status = result['status'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateAndTime": dateAndTime,
      "status":status,
    };
  }
}

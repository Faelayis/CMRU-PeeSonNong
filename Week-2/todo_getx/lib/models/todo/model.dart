class TodoModel {
  String title;
  String subtitle;
  bool isDone;

  TodoModel(
    this.title,
    this.subtitle,
    this.isDone,
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone,
    };
  }

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      json['title'],
      json['subtitle'],
      json['isDone'],
    );
  }
}

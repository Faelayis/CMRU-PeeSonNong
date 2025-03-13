class TodoModel {
  String uid;
  String title;
  String subtitle;
  bool isDone;

  TodoModel({
    this.uid = '',
    required this.title,
    required this.subtitle,
    required this.isDone,
  });

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'title': title, 'subtitle': subtitle, 'isDone': isDone};
  }

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      uid: json['uid'],
      title: json['title'],
      subtitle: json['subtitle'],
      isDone: json['isDone'],
    );
  }
}

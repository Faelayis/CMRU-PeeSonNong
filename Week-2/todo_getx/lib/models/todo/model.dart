class TodoModel {
  String uid;
  String docId;
  String title;
  String subtitle;
  bool isDone;

  TodoModel({
    this.uid = '',
    this.docId = '',
    required this.title,
    required this.subtitle,
    required this.isDone,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'docId': docId,
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone,
    };
  }

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      uid: json['uid'],
      docId: json['docId'],
      title: json['title'],
      subtitle: json['subtitle'],
      isDone: json['isDone'],
    );
  }
}

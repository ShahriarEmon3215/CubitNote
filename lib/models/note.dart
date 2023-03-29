class Note {
  int? id;
  String? title;
  String? body;
  String? creationDate;
  String? lastModified;

  Note({this.id, this.title, this.body, this.creationDate, this.lastModified});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      creationDate: json['creationDate'],
      lastModified: json['lastModified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['creationDate'] = creationDate;
    data['lastModified'] = lastModified;
    return data;
  }
}

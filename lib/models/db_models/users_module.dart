class Notes {
  int? id;
  String? title;
  String? content;

  Notes({
    this.id,
    this.title,
    this.content,
  });

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

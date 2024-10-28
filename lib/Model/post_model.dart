import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String? title;
  String? desc;
  String? email;
  DateTime? postedOn;

  Post({
    this.title,
    this.desc,
    this.email,
    this.postedOn,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        desc: json["desc"],
        email: json["email"],
        postedOn: json["postedOn"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
        "email": email,
        "postedOn": postedOn,
      };
}

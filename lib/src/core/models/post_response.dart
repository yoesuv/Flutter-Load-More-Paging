import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  static List<Post> buildListFromJson(List<dynamic> json) {
    return json.map((dynamic i) => Post.fromJson(i)).toList();
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        body,
      ];
}

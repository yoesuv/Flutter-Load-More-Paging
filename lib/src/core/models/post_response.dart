import 'package:equatable/equatable.dart';

class Post extends Equatable{

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(dynamic json) {
    userId = int.parse(json['userId'].toString());
    id = int.parse(json['id'].toString());
    title = json['title'].toString();
    body = json['body'].toString();
  }

  static List<Post> buildListFromJson(List<dynamic> json) {
    return json.map((dynamic i) => Post.fromJson(i)).toList();
  }

  int? userId;
  int? id;
  String? title;
  String? body;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  @override
  List<Object> get props => <Object>[id ?? 0, title ?? "", body ?? ""];

}
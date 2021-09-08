import 'package:bloc_load_more/src/core/models/post_response.dart';
import 'package:flutter/material.dart';

class ItemPost extends StatelessWidget {

  ItemPost(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title ?? "", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(post.body ?? "", style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }

}
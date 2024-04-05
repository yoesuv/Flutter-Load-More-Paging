import 'package:bloc_load_more/src/core/models/post_response.dart';
import 'package:flutter/material.dart';

class ItemPostGrid extends StatelessWidget {
  const ItemPostGrid(this.post, {super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title ?? "",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Expanded(
            child: Text(
              post.body ?? "",
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
            ),
          ),
        ],
      ),
    );
  }
}

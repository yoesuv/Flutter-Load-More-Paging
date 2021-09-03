import 'package:bloc_load_more/src/core/data/constants.dart';
import 'package:bloc_load_more/src/core/models/post_response.dart';
import 'package:bloc_load_more/src/core/networks/network_helper.dart';
import 'package:dio/dio.dart';

class AppRepository{

  final NetworkHelper _networkHelper = NetworkHelper();

  Future<List<Post>> getListPost(int start) async {
    final Response<dynamic> response = await _networkHelper.get('posts?_start=$start&_limit=$POST_LIMIT') as Response<dynamic>;
    return Post.buildListFromJson(response.data as List<dynamic>);
  }
}
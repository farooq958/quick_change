import 'package:example/api_check/service/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_change/quick_change.dart';

import 'model/post.dart';
// Import your quick_change package

class PostsController extends QuickChangeController<List<Post>> {
  final ApiService _apiService;

  PostsController(this._apiService);

  // Fetch posts and manage state
  Future<void> fetchPosts() async {
    setLoading(); // Set loading state

    try {
      List<Post> posts = await _apiService.fetchPosts();
      //print(posts.hashCode);
      setData(posts); // Set data state with the fetched posts
    } catch (error) {
      setError("Failed to fetch posts: ${error.toString()}"); // Set error state
    }
    finally {

    //  quickFlux(SuccessState("This is custom state "));

    } }
}

class SuccessState<T> extends QuickState {
  final T data;

  SuccessState(this.data);
}

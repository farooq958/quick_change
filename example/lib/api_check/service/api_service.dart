import 'dart:convert';
import 'package:example/api_check/model/post.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  // Fetch posts from the API
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse("$_baseUrl/posts"));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}

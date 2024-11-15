import 'package:example/api_check/model/post.dart';
import 'package:example/api_check/post_controller.dart';
import 'package:example/api_check/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:quick_change/quick_change.dart';


class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late final PostsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PostsController(ApiService());
    _controller.fetchPosts(); // Fetch posts when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: RefreshIndicator(
        onRefresh: () async{

          _controller.fetchPosts();
        },
        child: QuickChangeBuilder<List<Post>>(
          controller: _controller,
          onInitial: (context) => const Center(child: Text("Welcome!")),
          onLoading: (context) => const Center(child: CircularProgressIndicator()),
          onData: (context, posts) {

            print("generated again");
            return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
            },
          onCustom: (context, state) {
            if(state is SuccessState )
              {
                final posts=_controller.currentData;

            return ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
              }
            return const  SizedBox();

          },
          onError: (context, message) => Center(child: Text(message)),
        ).quickListen(controller: _controller, listener: (context,state){

          print(state);

        }),
      ),
    );
  }
}

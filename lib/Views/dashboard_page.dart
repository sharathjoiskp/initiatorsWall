import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initiator/Controllers/AuthCubit/auth_cubit.dart';
import 'package:initiator/Controllers/Repo/firestore_repo.dart';
import 'package:initiator/Controllers/Repo/local_db_repo.dart';
import 'package:initiator/Controllers/PostCubit/post_cubit.dart'; // Import PostCubit
import 'package:initiator/Views/add_post_page.dart';
import 'package:initiator/Views/login_page.dart';
import 'package:initiator/Model/post_model.dart';
import 'package:initiator/Views/posts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initiator\'s Wall'),
        actions: [
          IconButton(
            onPressed: () {
              LocalDbRepo().deleteUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AuthCubit(),
                    child: const LoginPage(),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => PostPage().showPostDialog(context),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is PostLoaded) {
            return StreamBuilder<List<Post>>(
              stream: state.postsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No posts available'));
                }

                final posts = snapshot.data!;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostListTile(post: post);
                  },
                );
              },
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

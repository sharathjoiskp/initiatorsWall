import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initiator/Controllers/PostCubit/post_cubit.dart';
import 'package:initiator/Controllers/Repo/local_db_repo.dart';
import 'package:initiator/Model/post_model.dart';

class PostPage {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void showPostDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Create New Post',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _postContent(context);
                  Navigator.pop(context); // Close the modal
                },
                child: const Text('Post'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _postContent(BuildContext context) async {
    final String title = titleController.text.trim();
    final String description = descController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      final postCubit = BlocProvider.of<PostCubit>(context);
      final userInfo = await LocalDbRepo().getUser();
      postCubit.addPost(
        Post(
          title: title,
          desc: description,
          email: userInfo['email'],
          postedOn: DateTime.now(),
        ),
      );

      titleController.clear();
      descController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Posted: $title')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both title and description')),
      );
    }
  }
}
